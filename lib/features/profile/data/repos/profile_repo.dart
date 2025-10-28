import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/core/networking/api_constants.dart';
import 'package:khouyot/features/favorite/data/models/wish_list_model.dart';
import 'package:khouyot/features/profile/data/models/change_password_model.dart';
import 'package:khouyot/features/profile/data/models/edit_profile_model.dart';
import 'package:khouyot/features/profile/data/models/edit_profile_response.dart';
import 'package:khouyot/features/profile/data/models/profile_model.dart';


class ProfileRepo {
  ProfileRepo(this.dio);
  final Dio dio;

  Future<Either<ApiErrorModel, ProfileModel>> getProfile() async {
    try {
      Response response = await dio.get(
        ApiConstants.profile,
      );
      return Right(ProfileModel.fromMap(
          response.data)); // Assuming the response has the profile data
    } catch (e) {
      log(e.toString());
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> deletAccount() async {
    try {
      Response response = await dio.delete(
        ApiConstants.deleteAccount,
      );
      return Right(response
          .data["message"]); // Assuming the response has the profile dat
    } catch (e) {
      log(e.toString());
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, EditProfileResponse>> featchProfileNew(
      {required EditProfileModel editProfile}) async {
    try {
      Response response =
          await dio.post(ApiConstants.profile, data: editProfile.toMap());
      return Right(EditProfileResponse.fromMap(response.data));
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> addToWishList(
      {required int productId}) async {
    try {
      Response response = await dio
          .post(ApiConstants.addToWishList, data: {"product_id": productId});
      return Right(response.data["message"]);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, List<WishListModel>>> getWishList() async {
    List<WishListModel> fav = [];
    try {
      Response response = await dio.get(ApiConstants.getWishList);
      for (var item in response.data["favorites"]) {
        fav.add(WishListModel.fromJson(item));
      }
      return Right(fav);
    } catch (e) {
      log(e.toString());
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> removeFromWishList({required int productId}) async {
    try {
      Response response = await dio.delete(
        ApiConstants.removeFromWishList,data: {
          "product_id": productId
        }
      );
      return Right(response
          .data["message"]); // Assuming the response has the profile dat
    } catch (e) {
      log(e.toString());
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> changePassword({
    required ChangePaswwordModel changePaswwordModel,
  }) async {
    try {
      Response response =
        await dio.post(ApiConstants.changePassword, data: changePaswwordModel.toMap());
        return Right(response.data['message']);
    }catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
