import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/core/networking/api_constants.dart';
import 'package:khouyot/features/auth/data/models/otp_model.dart';
import 'package:khouyot/features/auth/data/models/otp_response.dart';
import 'package:khouyot/features/auth/data/models/reset_password_model.dart';
import 'package:khouyot/features/auth/data/models/sign_in_model.dart';
import 'package:khouyot/features/auth/data/models/sign_in_response.dart';
import 'package:khouyot/features/auth/data/models/sign_up_model.dart';
import 'package:khouyot/features/auth/data/models/sign_up_response.dart';


class AuthRepo {
  AuthRepo(this.dio);
  final Dio dio;
  Future<Either<ApiErrorModel, SignInResponse>> signIn(
      {required SignInModel signIn}) async {
    try {
      Response response =
          await dio.post(ApiConstants.login, data: signIn.toMap());
      return Right(SignInResponse.fromMap(response.data));
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, SignUpResponse>> signUp({
    required SignUpModel signUp,
  }) async {
    try {
      Response response =
        await dio.post(ApiConstants.registeration, data: signUp.toMap());
        return Right(SignUpResponse.fromMap(response.data));
    }catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

Future<Either<ApiErrorModel, String >> forgetpassword({
    required String email,
  }) async {
    try {
      Response response =
        await dio.post(ApiConstants.forgotPassword, data: {"email":email});
        return Right(response.data['message']);
    }catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> resendCode({
    required String email,
  }) async {
    try {
      Response response =
        await dio.post(ApiConstants.resendCode, data: {"email":email});
        return Right(response.data['message']);
    }catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
  
  Future<Either<ApiErrorModel, OtpResponse>> otp({
    required OtpModel otpModel,
  }) async {
    try {
      Response response =
        await dio.post(ApiConstants.otp, data: otpModel.toMap());
        return Right(OtpResponse.fromMap(response.data));
    }catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> resetPssword({
    required ResetPasswordModel resetPasswordModel,
  }) async {
    try {
      Response response =
        await dio.post(ApiConstants.resetPassword, data: resetPasswordModel.toMap());
        return Right(response.data['message']);
    }catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}
