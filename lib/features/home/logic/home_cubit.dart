import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khouyot/core/db/cached_app.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/models/filter_categorie_model.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/features/home/data/repos/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial()) {
    scrollControllerAll.addListener(onScrollAll);
    scrollControllerCurrent.addListener(onScrollCurrent);
  }

  final HomeRepo homeRepo;
  static HomeCubit get(context) => BlocProvider.of(context);

  int currentPageIndex = 0;
  int currentImageIndex = 0;
  String currentCategory = "All";
  int currentId = 0;
  int num = 0;

  final ScrollController scrollControllerAll = ScrollController();
  final ScrollController scrollControllerCurrent = ScrollController();

  bool isLoadingMoreAll = false;
  bool isLoadingMoreCurrent = false;

  /// Paging
  int allPage = 1;
  int categoryPage = 1;

  /// Use Data directly everywhere
  final Map<String, List<Data>> categoriesMap = {};
  List<Data> allProducts = [
    Data(
      id: 0,
      name: "Product 1",
      description: "Description here",
      minPrice: 25,
      maxPrice: 25,
      category: Category(id: 1, name: "Category A", slug: "category-a"),
      variants: [
        Variants(
          id: 1,
          sku: "SKU001",
          price: "25",
          stock: 10,
          stockStatus: "in_stock",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s",
        ),
      ],
    ),
    Data(
      id: 1,
      name: "Product 2",
      minPrice: 250,
      maxPrice: 250,
      category: Category(id: 2, name: "Category B", slug: "category-b"),
      variants: [
        Variants(
          id: 2,
          sku: "SKU002",
          price: "250",
          stock: 5,
          stockStatus: "in_stock",
          image:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s",
        ),
      ],
    ),
  ];

  void changeCurrentCategory(String name) {
    currentCategory = name;
    emit(ChangePageBody());
  }

  void changeImageIndex(int index) {
    currentImageIndex = index;
    emit(ChangeImageIndex());
  }

  void changeId(int id) {
    currentId = id;
    emit(ChangeId());
  }

  void changeSelectedColor1(Color color) {
    selectedColor1 = color;
    emit(ColorChanged1());
  }

  void changeSelectedColor2(Color color) {
    selectedColor2 = color;
    emit(ColorChanged2());
  }

  Color selectedColor1 = Colors.transparent;
  String selectedSize1 = "Select Size";
  Color selectedColor2 = Colors.transparent;
  String selectedSize2 = "Select Size";

  void changeSelectedSize1(String size) {
    switch (size) {
      case 'S':
        selectedSize1 = "Small";
        break;
      case 'M':
        selectedSize1 = "Medium";
        break;
      case 'L':
        selectedSize1 = "Large";
        break;
      case 'XL':
        selectedSize1 = "Extra Large";
        break;
      default:
        selectedSize1 = size;
    }
    emit(SizeChanged1());
  }

  void changeSelectedSize2(String size) {
    switch (size) {
      case 'S':
        selectedSize2 = "Small";
        break;
      case 'M':
        selectedSize2 = "Medium";
        break;
      case 'L':
        selectedSize2 = "Large";
        break;
      case 'XL':
        selectedSize2 = "Extra Large";
        break;
      default:
        selectedSize2 = size;
    }
    emit(SizeChanged2());
  }

  Future<void> fetchAllProducts({bool getOnlyFormNetwork = false}) async {
    log("Fetching all products");
    try {
      if (getOnlyFormNetwork) throw "Data not found in cache";

      final cached = CachedApp.getCachedData(CachedDataType.products.name);
      if (cached is List<Data>) {
        allPage = 1; // reset paging when loading initial list
        allProducts = cached;
        log("✅ [HomeCubit] Loaded ${allProducts.length} products from cache");
        emit(ProductAllSuccess());
        return;
      } else {
        throw "Cache type mismatch or empty";
      }
    } catch (e) {
      log("❌ [HomeCubit] Cache miss: $e");
      emit(ProductAllLoading());

      final connectivity = await Connectivity().checkConnectivity();
      if (!connectivity.contains(ConnectivityResult.none)) {
        allPage = 1; // first page
        final response = await homeRepo.fetchAllHomeData(page: allPage);
        response.fold((error) {
          log("❌ [HomeCubit] API error: ${error.message}");
          allProducts = [];
          emit(ProductAllFailure(error));
        }, (items) async {
          allProducts = items;
          log("✅ [HomeCubit] Received ${allProducts.length} items from API");
          if (allProducts.isNotEmpty) {
            log("✅ [HomeCubit] First product: ${allProducts.first.name}, ID: ${allProducts.first.id}");
          }
          CachedApp.saveData(allProducts, CachedDataType.products.name);
          emit(ProductAllSuccess());
        });
      } else {
        allProducts = [];
        Fluttertoast.showToast(
          msg: "No internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorsManager.kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        emit(ProductAllFailure(ApiErrorModel(message: 'No internet connection')));
      }
    }
  }

  Future<void> fetchProductAtSpecificCategories(
    int id,
    String name, {
    bool getOnlyFormNetwork = false,
  }) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (!connectivity.contains(ConnectivityResult.none)) {
      try {
        if (getOnlyFormNetwork) throw "Data not found in cache";

        final cached =
            CachedApp.getCachedData("${CachedDataType.products.name}_$name");
        if (cached is List<Data>) {
          categoryPage = 1; // reset paging
          categoriesMap[name] = cached;
          emit(FetchProductAtSpecificCategoriesSuccess());
          return;
        } else {
          throw "Cache type mismatch or empty";
        }
      } catch (e) {
        emit(FetchProductAtSpecificCategoriesLoading());
        categoryPage = 1;

        final response = await homeRepo.fetchCategoryData(
          categoryId: id,
          page: categoryPage,
        );

        response.fold((error) {
          categoriesMap[name] = [];
          emit(FetchProductAtSpecificCategoriesFailure(error));
        }, (items) {
          categoriesMap[name] = items;
          CachedApp.saveData(
            items,
            "${CachedDataType.products.name}_$name",
          );
          emit(FetchProductAtSpecificCategoriesSuccess());
        });
      }
    } else {
      Fluttertoast.showToast(
        msg: "No internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorsManager.kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(FetchProductAtSpecificCategoriesFailure(
        ApiErrorModel(message: 'No internet connection'),
      ));
    }
  }

  // ===== Infinite Scroll: All =====
  void onScrollAll() async {
    if (scrollControllerAll.position.pixels >=
            scrollControllerAll.position.maxScrollExtent - 50 &&
        !isLoadingMoreAll) {
      isLoadingMoreAll = true;
      await fetchMoreProducts();
      isLoadingMoreAll = false;
    }
  }

  Future<void> fetchMoreProducts() async {
    emit(ProductAllLoadingMore());

    final connectivity = await Connectivity().checkConnectivity();
    if (!connectivity.contains(ConnectivityResult.none)) {
      allPage += 1;
      final response = await homeRepo.fetchAllHomeData(page: allPage);
      response.fold((error) {
        emit(ProductAllFailure(error));
      }, (items) async {
        allProducts.addAll(items); // ✅ append new page
        CachedApp.saveData(allProducts, CachedDataType.products.name);
        emit(FetchMoreProductsSuccess());
      });
    } else {
      Fluttertoast.showToast(
        msg: "No internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorsManager.kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(FetchMoreProductsFailure(
        ApiErrorModel(message: 'No internet connection'),
      ));
    }
  }

  // ===== Infinite Scroll: Current Category =====
  void onScrollCurrent() async {
    if (scrollControllerCurrent.position.pixels >=
            scrollControllerCurrent.position.maxScrollExtent - 50 &&
        !isLoadingMoreCurrent &&
        currentCategory != "All" &&
        currentId != 0) {
      isLoadingMoreCurrent = true;
      await fetchMoreProductAtSpecificCategories(currentId, currentCategory);
      isLoadingMoreCurrent = false;
    }
  }

  Future<void> fetchMoreProductAtSpecificCategories(int id, String name) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (!connectivity.contains(ConnectivityResult.none)) {
      emit(MoreProductSpecificLoading());
      categoryPage += 1;

      final response =
          await homeRepo.fetchCategoryData(categoryId: id, page: categoryPage);
      response.fold((error) {
        emit(MoreProductSpecificFailure(error));
      }, (items) {
        categoriesMap.putIfAbsent(name, () => []);
        categoriesMap[name]!.addAll(items);
        emit(MoreProductSpecificSuccess());
      });
    } else {
      Fluttertoast.showToast(
        msg: "No internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorsManager.kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(MoreProductSpecificFailure(
        ApiErrorModel(message: 'No internet connection'),
      ));
    }
  }

  void increment() {
    num += 1;
    emit(Increment());
  }

  void decrement() {
    if (num > 1) {
      num -= 1;
      emit(Decrement());
    }
  }

  // Helper method to get English display names from slugs
  String getEnglishDisplayName(CategoryData category) {
    if (category.slug == null) return 'Unknown';
    final slug = category.slug!.toLowerCase();
    switch (slug) {
      case 'electronics':
      case 'electronic':
        return 'Electronics';
      case 'clothing':
      case 'clothng':
        return 'Clothing';
      case 'shoes':
      case 'shoe':
        return 'Shoes';
      case 'home-appliances':
      case 'home-appliance':
        return 'Home Appliances';
      case 'beauty':
      case 'beyuty':
        return 'Beauty';
      case 'sports':
      case 'sport':
        return 'Sports';
      case 'books':
      case 'book':
        return 'Books';
      case 'toys':
      case 'toy':
        return 'Toys';
      case 'trh':
      case 'trha':
        return 'Scarves';
      default:
        return slug
            .replaceAll('-', ' ')
            .split(' ')
            .map((w) => w.isEmpty ? w : (w[0].toUpperCase() + w.substring(1)))
            .join(' ');
    }
  }
}
