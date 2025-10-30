import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/product_details/data/model/prodec_details_model.dart';
import 'package:khouyot/features/product_details/data/repo/Product_dtails_repo.dart';
import 'package:meta/meta.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productDetailsRepo) : super(ProductDetailsInitial());
  ProductDetailsRepo productDetailsRepo;
  static ProductDetailsCubit get(context)=> BlocProvider.of(context);
  Color selectedColor1 = Colors.transparent;
  void changeSelectedColor1(Color color) {
    selectedColor1 = color;
    emit(ColorChanged1());
  }
  String selectedSize1 = "Select Size";
  void changeSelectedSize1(String size) {
    switch (size) {
      case 'S':
        selectedSize1 = "Small";
        break;
      case 'M':
        selectedSize1 = "Medium";
        break;
      case 'L':
        selectedSize1 = "Large";
        break;
      case 'XL':
        selectedSize1 = "Extra Large";
        break;
      default:
        selectedSize1 = size;
    }
    emit(SizeChanged1());
  }
  int currentImageIndex = 0;

  void changeImageIndex(int index) {
    currentImageIndex = index;
    emit(ChangeImageIndex());
  }
ProductDetailsModel? productModel;
  Future<void> getProductDetails(int id) async{
    emit(ProductDetailsLoading());
    var  response= await productDetailsRepo.getProductDetails(id);
response.fold((l){

  emit(ProductDetailsFail());
}, (r){
  productModel=r;
  emit(ProductDetailsSuccess());
});
  }

}
