import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/core/networking/api_constants.dart';
import 'package:khouyot/features/favorite/data/models/wish_list_model.dart';


class FavRepo {
  FavRepo(this.dio);
  Dio dio;

  Future<Either<ApiErrorModel, String>> addToWishList({required int productId}) async {
    try {
      log("➡️ [FavRepo] Sending Add To Wishlist request with productId: $productId");
      Response response = await dio.post(
        ApiConstants.addToWishList,
        data: {"product_id": productId},
      );
      log("✅ [FavRepo] AddToWishList response: ${response.data}");
      return Right(response.data["message"]);
    } catch (e) {
      log("❌ [FavRepo] AddToWishList error: $e");
      return Left(ApiErrorHandler.handle(e));
    }
  }

  // Future<Either<ApiErrorModel, List<DataWish>>> getWishList() async {
  //   List<DataWish> fav = [];
  //   try {
  //     log("➡️ [FavRepo] Fetching Wishlist...");
  //     Response response = await dio.get(ApiConstants.getWishList);
  //     log("✅ [FavRepo] GetWishList response: ${response.data}");

  //     for (var item in response.data["favorites"]) {
  //       fav.add(DataWish.fromJson(item));
  //     }

  //     return Right(fav);
  //   } catch (e) {
  //     log("❌ [FavRepo] GetWishList error: $e");
  //     return Left(ApiErrorHandler.handle(e));
  //   }
  // }
  Future<Either<ApiErrorModel, List<DataWish>>> getWishList() async {
  List<DataWish> fav = [];
  try {
    log("➡️ [FavRepo] Fetching Wishlist...");
    Response response = await dio.get(ApiConstants.getWishList);
    log("✅ [FavRepo] GetWishList response received");

    // Handle different response formats
    if (response.data is Map) {
      final Map<String, dynamic> data = response.data;
      if (data.containsKey('data')) {
        final List<dynamic> items = data['data'] ?? [];
        for (var item in items) {
          fav.add(DataWish.fromJson(item));
        }
      }
    } else if (response.data is List) {
      // If response is directly a list
      final List<dynamic> items = response.data;
      for (var item in items) {
        fav.add(DataWish.fromJson(item));
      }
    }

    log("✅ [FavRepo] Successfully parsed ${fav.length} wishlist items");
    return Right(fav);
  } catch (e) {
    log("❌ [FavRepo] GetWishList error: $e");
    return Left(ApiErrorHandler.handle(e));
  }
}


  Future<Either<ApiErrorModel, String>> removeFromWishList({required int productId}) async {
    try {
      log("➡️ [FavRepo] Removing productId: $productId from wishlist...");
      Response response = await dio.delete(
        ApiConstants.removeFromWishList,
        data: {"product_id": productId},
      );
      log("✅ [FavRepo] RemoveFromWishList response: ${response.data}");
      return Right(response.data["message"]);
    } catch (e) {
      log("❌ [FavRepo] RemoveFromWishList error: $e");
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
