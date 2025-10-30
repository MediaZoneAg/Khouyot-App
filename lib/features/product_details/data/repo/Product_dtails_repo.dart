import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/features/product_details/ui/product_details.dart';

import '../model/prodec_details_model.dart';

class ProductDetailsRepo {
  Dio dio;
  ProductDetailsRepo(this.dio);
  Future<Either<ApiErrorModel, ProductDetailsModel>> getProductDetails(
      int id) async {
    try {
      var response = await dio.get('/products/$id');
      return right(ProductDetailsModel.fromJson(response.data));
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }

  Future<Either<ApiErrorModel, String>> addToCart(int id) async {
    try {
      var res = await dio.post('cart/add/$id');
      return right('status');
    } catch (e) {
      return left(ApiErrorHandler.handle(e));
    }
  }
}
