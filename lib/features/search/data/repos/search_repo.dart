import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/errors/error_handler.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/networking/api_constants.dart';


class SearchRepo {
  SearchRepo(this.dio);
  final Dio dio;

  Future<Either<ApiErrorModel, List<ProductModel>>> getSearch(
      {required String search,
      required double minPrice ,
      required double maxPrice,
      required String currentCategoryId}) async {
    try {
      //?search=rice&min_price=10&max_price=50&category?name=humanitarian
      Response response = await dio.get(ApiConstants.search, queryParameters: {
        'search': search,
        'min_price': minPrice,
        'max_price': maxPrice,
        'category': currentCategoryId
      });
      List<ProductModel> products = (response.data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
      return Right(products);
    } catch (e) {
      return Left(ApiErrorHandler.handle(e));
    }
  }
}