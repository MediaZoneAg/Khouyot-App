import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/core/models/filter_categorie_model.dart';
import 'package:khouyot/core/models/parent_category_model.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/networking/api_constants.dart';


class CategoryRepo {
  CategoryRepo(this.dio);
  final Dio dio;

  // Future<Either<ApiErrorModel, List<ParentCategoryModel>>> fetchCategoryData(int categoryId) async {
  //   List<ParentCategoryModel> categories = [];
  //   try {
  //     log("➡️ [CategoryRepo] Fetching parent category: $categoryId");
  //     Response response = await dio.get("${ApiConstants.categories}/$categoryId");
  //     log("✅ [CategoryRepo] Response: ${response.data}");

  //     for (var element in response.data) {
  //       categories.add(ParentCategoryModel.fromJson(element));
  //     }
  //     return Right(categories);
  //   } catch (e) {
  //     log("❌ [CategoryRepo] fetchCategoryData error: $e");
  //     return Left(ApiErrorHandler.handle(e));
  //   }
  // }
 Future<Either<ApiErrorModel, FilterCategorieModel>> fetchCategoriesData() async {
    try {
      log("➡️ [CategoryRepo] Fetching all categories");
      Response response = await dio.get(ApiConstants.categories);
      log("✅ [CategoryRepo] Response received successfully");

      // The API returns a single FilterCategorieModel object with a data array
      final categoriesData = FilterCategorieModel.fromJson(response.data);
      log("✅ [CategoryRepo] Parsed ${categoriesData.data?.length ?? 0} categories");
      
      return Right(categoriesData);
    } catch (e) {
      log("❌ [CategoryRepo] fetchCategoriesData error: $e");
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<ParentCategoryModel>>> fetchChildCategoryData(String name) async {
  List<ParentCategoryModel> categories = [];
  try {
    log("➡️ [CategoryRepo] Fetching child categories for parent: $name");
    
    // First, try to get the parent category ID from the name/slug
    final parentCategoriesResponse = await dio.get(ApiConstants.categories);
    final parentCategories = FilterCategorieModel.fromJson(parentCategoriesResponse.data);
    
    // Find the parent category by name or slug
    final parentCategory = parentCategories.data?.firstWhere(
      (category) => category.slug == name || category.slug == name,
      orElse: () => CategoryData(),
    );
    
    if (parentCategory?.id == null) {
      log("❌ [CategoryRepo] Parent category not found: $name");
      return Left(ApiErrorModel(message: "Parent category not found"));
    }
    
    // Now fetch children using the parent ID
    Response response = await dio.get("${ApiConstants.categories}/${parentCategory!.id}/children");
    log("✅ [CategoryRepo] Response: ${response.data}");

    // Handle different response formats
    if (response.data is Map && response.data.containsKey('data')) {
      final List<dynamic> data = response.data['data'];
      for (var element in data) {
        categories.add(ParentCategoryModel.fromJson(element));
      }
    } else if (response.data is List) {
      for (var element in response.data) {
        categories.add(ParentCategoryModel.fromJson(element));
      }
    }

    return Right(categories);
  } on DioException catch (e) {
    if (e.response?.statusCode == 404) {
      log("❌ [CategoryRepo] Endpoint not found, returning empty list");
      return Right([]); // Return empty list instead of error
    }
    log("❌ [CategoryRepo] fetchChildCategoryData error: $e");
    return Left(ApiErrorHandler.handle(e));
  } catch (e) {
    log("❌ [CategoryRepo] fetchChildCategoryData error: $e");
    return Left(ApiErrorHandler.handle(e));
  }
}
  Future<Either<ApiErrorModel, List<ParentCategoryModel>>> fetchChildSubCategoryData(int category) async {
    List<ParentCategoryModel> categories = [];
    try {
      log("➡️ [CategoryRepo] Fetching child subcategories for category: $category");
      Response response = await dio.get(ApiConstants.chCategories, queryParameters: {'category': category});
      log("✅ [CategoryRepo] Response: ${response.data}");

      for (var element in response.data) {
        categories.add(ParentCategoryModel.fromJson(element));
      }
      return Right(categories);
    } catch (e) {
      log("❌ [CategoryRepo] fetchChildSubCategoryData error: $e");
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<ProductModel>>> fetchProductCategoryData(int category, int prePageNum) async {
    List<ProductModel> categories = [];
    try {
      log("➡️ [CategoryRepo] Fetching products for category: $category page: $prePageNum");
      Response response = await dio.get(ApiConstants.products);
      log("✅ [CategoryRepo] Response: ${response.data}");

      for (var element in response.data) {
        categories.add(ProductModel.fromJson(element));
      }
      return Right(categories);
    } catch (e) {
      log("❌ [CategoryRepo] fetchProductCategoryData error: $e");
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
