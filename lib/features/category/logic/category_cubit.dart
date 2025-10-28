import 'dart:developer';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khouyot/core/db/cached_app.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/models/filter_categorie_model.dart';
import 'package:khouyot/core/models/parent_category_model.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/features/category/data/repos/category_repo.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.categoryRepo) : super(CategoryInitial()) {
    scrollController.addListener(_onScroll);
  }
  CategoryRepo categoryRepo;
  List<Data> productList = [];

  static CategoryCubit get(context) => BlocProvider.of(context);

  ScrollController scrollController = ScrollController();
  bool isLoadingMore = false;

  int currentPageIndex = 0;
  int prePageNum = 1;
  int currentId = 1;
  int? currentContentIndex;
  int? currentSubContentIndex;
  bool isClicked = false;
  List<ProductModel> productSubSubCategoriesList = [];
  Map<String, List<ParentCategoryModel>> categoriesMap = {};
  final Map<int, List<Data>> categoryProductsMap =
      {}; // categoryId -> List<Data>

  final Map<int, Map<String, List<String>>> categoryOptionsMap =
      {}; // categoryId -> {optionName: [values...]}

  List<CategoryData> allCategories = [];
  List<CategoryData> get topLevelCategories {
    return allCategories.where((category) => category.isTopLevel).toList();
  }

  // Get categories for display in the horizontal list
  List<CategoryData> get categoriesForFilter {
    // Return top-level categories for the filter list
    return topLevelCategories;
  }

  List<FilterCategorieModel> categories = [
    FilterCategorieModel(data: [
      CategoryData(
        id: 1,
        name: 'Dress',
      ),
      CategoryData(
        id: 1,
        name: 'Dress',
      ),
      CategoryData(
        id: 1,
        name: 'Dress',
      ),
    ]),
  ];

  final List<String> mainCategories = [
    'Clothes',
    'Shoes',
    'Hats',
    'Bags',
  ];

  final List<String> subCategories = [
    'View all',
    'Dress',
    'T-shirts',
    'Pants',
  ];
  String currentParentSlug = "";

  void changeCurrentIndex(int index, int id, String slug) {
    currentId = id;
    currentPageIndex = index;
    currentParentSlug = slug;
    emit(ChangePageBody());
  }

  void changeCurrentContentIndex(int index) {
    currentContentIndex = index;
    emit(ChangeContentBody());
  }

  void changeSubContentIndex(int index, bool clicked) {
    currentSubContentIndex = index;
    isClicked = clicked;
    emit(ChangeContentBody());
  }

  String? selectedsubCategory;
  String? selectedMainCategory;
  void subSelectCategory(String categoryName) {
    selectedsubCategory = categoryName;
    emit(SubCategorySelected()); // Emit new state with selected category
  }

  void mainSelectCategory(String categoryName) {
    selectedMainCategory = categoryName;
    emit(SubCategorySelected()); // Emit new state with selected category
  }

  Future<void> fetchCategories({bool getOnlyFormNetwork = false}) async {
    try {
      // Try to get from cache first
      final cachedData =
          CachedApp.getCachedData(CachedDataType.categories.name);
      if (cachedData is FilterCategorieModel) {
        allCategories = cachedData.data ?? [];
        emit(CategorySuccess());
        return;
      }
    } catch (e) {
      log("No cached categories found: $e");
    }

    emit(CategoryLoading());

    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await categoryRepo.fetchCategoriesData();

      await response.fold((error) {
        allCategories = [];
        emit(CategoryFailure(error));
      }, (categoriesData) async {
        // Store the complete categories data
        allCategories = categoriesData.data ?? [];
        emit(CategorySuccess());

        // Save to cache
        CachedApp.saveData(categoriesData, CachedDataType.categories.name);
      });
    } else {
      allCategories = [];
      Fluttertoast.showToast(
        msg: "No internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorsManager.kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(CategoryFailure(ApiErrorModel(message: 'No internet connection')));
    }
  }

  // Find category by name
  CategoryData? findCategoryByName(String name) {
    return allCategories.firstWhere(
      (category) => category.name == name,
      orElse: () => CategoryData(),
    );
  }

  // Find category by ID
  CategoryData? findCategoryById(int id) {
    return allCategories.firstWhere(
      (category) => category.id == id,
      orElse: () => CategoryData(),
    );
  }

  Future<void> fetchChildCategories(String slug,
      {bool getOnlyFormNetwork = false}) async {
    try {
      categoriesMap[slug] =
          CachedApp.getCachedData("${CachedDataType.categories.name}_$slug");
      emit(ChildCategorySuccess());
    } catch (_) {
      emit(ChildCategoryLoading());
      final connectivity = await Connectivity().checkConnectivity();
      if (!connectivity.contains(ConnectivityResult.none)) {
        final res = await categoryRepo.fetchChildCategoryData(slug);
        res.fold((err) {
          emit(ChildCategoryFailure(err));
        }, (list) {
          // ✅ actually assign:
          categoriesMap[slug] = list;
          CachedApp.saveData(list, "${CachedDataType.categories.name}_$slug");
          emit(ChildCategorySuccess());
        });
      } else {
        emit(ChildCategoryFailure(
            ApiErrorModel(message: 'No internet connection')));
      }
    }
  }

  Future<void> fetchChildSubCategories(int id, int index,
      {bool getOnlyFormNetwork = false}) async {
    emit(ChildSubCategoryLoading());
    final connectivityResult = await Connectivity().checkConnectivity();
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await categoryRepo.fetchChildSubCategoryData(id);
      response.fold(
        (error) {
          emit(ChildSubCategoryFailure(error));
        },
        (categoriesData) {
          log(id.toString());
          log(" sssssssssssss ${categoriesMap}");
          log("yaraaaaaaa ${categoriesMap[id.toString()]}");
          if (index >= 0 &&
              categoriesMap[currentId.toString()] !=
                  null && // Ensure it's not null
              index < categoriesMap[currentId.toString()]!.length) {
            categoriesMap[currentId.toString()]![index]
                .subCategories
                .add(categoriesData[0]);
          }
          emit(ChildSubCategorySuccess());
        },
      );
    } else {
      emit(ChildSubCategoryFailure(
          ApiErrorModel(message: 'No internet connection')));
    }
  }

 Future<void> fetchProductSubSubCategories(int categoryId, {bool getOnlyFormNetwork=false}) async {
  final connectivity = await Connectivity().checkConnectivity();
  if (!connectivity.contains(ConnectivityResult.none)) {
    try {
      if (getOnlyFormNetwork) throw 'forceNetwork';

      // try cache
      final cached = CachedApp.getCachedData("${CachedDataType.productsCategory.name}_$categoryId");
      if (cached is List<Data> && cached.isNotEmpty) {
        productList = cached;
        categoryProductsMap[categoryId] = cached;          // ✅ store per leaf
        _extractOptionsFromProducts(categoryId);            // ✅ build options map
        emit(FetchProductSubSubCategoriesSuccess());
        return;
      }
    } catch (_) { /* fallthrough to network */ }

    emit(FetchProductSubSubCategoriesLoading());
    final res = await categoryRepo.fetchProductCategoryData(categoryId, prePageNum);
    res.fold((err) {
      productList = [];
      emit(FetchProductSubSubCategoriesFailure(err));
    }, (list) {
      productList = list;
      categoryProductsMap[categoryId] = list;              // ✅ store per leaf
      _extractOptionsFromProducts(categoryId);              // ✅ build options map
      CachedApp.saveData(list, "${CachedDataType.productsCategory.name}_$categoryId");
      emit(FetchProductSubSubCategoriesSuccess());
    });
  } else {
    productList = [];
    Fluttertoast.showToast(msg: "No internet Connection", backgroundColor: ColorsManager.kPrimaryColor);
    emit(FetchProductSubSubCategoriesFailure(ApiErrorModel(message: 'No internet connection')));
  }
}

  void _extractOptionsFromProducts(int categoryId) {
    final products = categoryProductsMap[categoryId] ?? [];
    final Map<String, Set<String>> aggregated = {};

    for (final p in products) {
      for (final opt in (p.options ?? [])) {
        final name = opt.name ?? "";
        if (name.isEmpty) continue;
        aggregated.putIfAbsent(name, () => {});
        for (final v in (opt.values ?? [])) {
          if (v.value != null && v.value!.isNotEmpty) {
            aggregated[name]!.add(v.value!);
          }
        }
      }
    }
    categoryOptionsMap[categoryId] = {
      for (final entry in aggregated.entries) entry.key: entry.value.toList()
    };
  }

  void _onScroll() async {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        !isLoadingMore) {
      isLoadingMore = true;
      log("aaaaaaaaa");
      prePageNum += 1;
      await fetchMoreProducts(currentId);
      isLoadingMore = false;
    }
  }

  Future<void> fetchMoreProducts(int categoryId) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (!connectivity.contains(ConnectivityResult.none)) {
      emit(ProductAllLoadingMore());
      final res = await categoryRepo.fetchProductCategoryData(
          categoryId, prePageNum + 1);
      res.fold((err) {
        emit(FetchMoreProductsFailure(err));
      }, (list) {
        prePageNum += 1;
        productList.addAll(list); // ✅ append new Data
        emit(FetchMoreProductsSuccess());
      });
    } else {
      emit(FetchMoreProductsFailure(
          ApiErrorModel(message: 'No internet connection')));
    }
  }
}
