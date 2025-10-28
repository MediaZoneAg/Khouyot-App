import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SplashRepo {
  SplashRepo(this.dio); // dio is not required, which can lead to a null value
  final Dio dio;


  Future <Either<void,void>> checkToken(String token)async{
    try{
    dio.post('custom-api/v1/manual-validate',data:{"token":token}) ;
      return Right('welcome');
    }catch(e){
      return Left("error");
    }
  }
}