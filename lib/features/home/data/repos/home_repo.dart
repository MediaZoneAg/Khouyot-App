import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/networking/api_constants.dart';

class HomeRepo {
  HomeRepo(this.dio);
  final Dio dio;

  /// Returns the flat list of products (Data)
  Future<Either<ApiErrorModel, List<Data>>> fetchAllHomeData({int page = 1}) async {
    try {
      log("➡️ [HomeRepo] Fetching products page=$page");
      final Response response = await dio.get(ApiConstants.products, queryParameters: {
        'page': page,
      });

      log("✅ [HomeRepo] Status: ${response.statusCode}");
      if (response.data is! Map || !(response.data as Map).containsKey('data')) {
        return Right(<Data>[]);
      }

      final model = ProductModel.fromJson(response.data as Map<String, dynamic>);
      final items = model.data ?? <Data>[];
      log("✅ [HomeRepo] Parsed ${items.length} products");
      return Right(items);
    } catch (e) {
      log("❌ [HomeRepo] fetchAllHomeData error: $e");
      return Left(ApiErrorHandler.handle(e));
    }
  }

  /// Returns the flat list of products (Data) for a category
  Future<Either<ApiErrorModel, List<Data>>> fetchCategoryData({
    required int categoryId,
    required int page,
  }) async {
    try {
      log("➡️ [HomeRepo] Fetching category=$categoryId page=$page");
      final Response response = await dio.get(
        ApiConstants.products,
        queryParameters: {
          'category': categoryId,
          'page': page,
        },
      );

      if (response.data is Map && (response.data as Map).containsKey('data')) {
        final model = ProductModel.fromJson(response.data as Map<String, dynamic>);
        final items = model.data ?? <Data>[];
        log("✅ [HomeRepo] Parsed ${items.length} category products");
        return Right(items);
      }

      return Right(<Data>[]);
    } catch (e) {
      log("❌ [HomeRepo] fetchCategoryData error: $e");
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
