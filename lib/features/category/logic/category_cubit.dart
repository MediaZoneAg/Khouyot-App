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

  void changeCurrentIndex(int index, int id) {
    currentId = id;
    currentPageIndex = index;
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
      final cachedData = CachedApp.getCachedData(CachedDataType.categories.name);
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
  } catch (e) {
    emit(ChildCategoryLoading());
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      final response = await categoryRepo.fetchChildCategoryData(slug);
      response.fold((error) {
        categories = [];
        emit(ChildCategoryFailure(error));
      }, (categoriesData) {
        categoriesMap[slug];
        CachedApp.saveData(
            categoriesData, "${CachedDataType.categories.name}_$slug");
        emit(ChildCategorySuccess());
      });
    } else {
      categories = [];
      Fluttertoast.showToast(
        msg: "No internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorsManager.kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
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

  Future<void> fetchProductSubSubCategories(int id,
      {bool getOnlyFormNetwork = false}) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      try {
        if (getOnlyFormNetwork) {
          throw "Data not found in cache";
        }
        productSubSubCategoriesList = CachedApp.getCachedData(
            "${CachedDataType.productsCategory.name}_$id");
        emit(FetchProductSubSubCategoriesSuccess());
      } catch (e) {
        emit(FetchProductSubSubCategoriesLoading());
        final response =
            await categoryRepo.fetchProductCategoryData(id, prePageNum);
        response.fold((error) {
          productSubSubCategoriesList = [];
          emit(FetchProductSubSubCategoriesFailure(error));
        }, (productSubSubCategoriesData) {
          productSubSubCategoriesList = productSubSubCategoriesData;
          CachedApp.saveData(productSubSubCategoriesData,
              "${CachedDataType.productsCategory.name}_$id");
          emit(FetchProductSubSubCategoriesSuccess());
        });
      }
    } else {
      productSubSubCategoriesList = [];
      Fluttertoast.showToast(
        msg: "No internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorsManager.kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(FetchProductSubSubCategoriesFailure(
          ApiErrorModel(message: 'No internet connection')));
    }
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

  Future<void> fetchMoreProducts(int id) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      emit(ProductAllLoadingMore());
      final response =
          await categoryRepo.fetchProductCategoryData(id, prePageNum);
      response.fold((error) {
        productSubSubCategoriesList = [];
        emit(FetchMoreProductsFailure(error));
      }, (productSubSubCategoriesData) {
        productSubSubCategoriesList.addAll(productSubSubCategoriesData);
        emit(FetchMoreProductsSuccess());
      });
    } else {
      productSubSubCategoriesList = [];
      Fluttertoast.showToast(
        msg: "No internet Connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: ColorsManager.kPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      emit(FetchMoreProductsFailure(
          ApiErrorModel(message: 'No internet connection')));
    }
  }
}
