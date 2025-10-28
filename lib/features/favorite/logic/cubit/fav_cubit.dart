import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khouyot/core/db/cached_app.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/models/image_product_model.dart';
import 'package:khouyot/core/models/product_model.dart' hide Data;
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/features/favorite/data/models/wish_list_model.dart';
import 'package:khouyot/features/favorite/data/repos/fav_repo.dart';
import 'package:meta/meta.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit(this.favRepo) : super(FavInitial());
  static FavCubit get(context) => BlocProvider.of(context);
  final FavRepo favRepo;

  List<int> favorite = [];

  List<DataWish> wishList = [
    DataWish(
      name: "Product 1", price: "100", imageModels: [
      ImageModel(
          src:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s"),
    ]),
    DataWish(name: "Product 2", price: "200", imageModels: [
      ImageModel(
          src:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s"),
    ]),
    DataWish(name: "Product 3", price: "300", imageModels: [
      ImageModel(
          src:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s"),
    ]),
    DataWish(name: "Product 3", price: "300", imageModels: [
      ImageModel(
          src:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbzP5tsc2Hiy2r5O1Y6OMtT4iIz903c0a7iQ&s"),
    ])
  ];
  Future<void> addToWishList({required ProductModel model}) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      wishList.add(DataWish(
        id: model.data?.first.id,
        name: model.data?.first.name,
        price: model.data?.first.variants?.first.price,
        imageModels: model.data?.first.variants?.first.image != null
            ? [ImageModel(src: model.data!.first.variants!.first.image!)]
            : [],
      ));
      favorite.add(model.data!.first.id!);
      emit(AddToWishListLoading());
      final response =
          await favRepo.addToWishList(productId: model.data!.first.id!);
      response.fold((l) {
        wishList.removeWhere((element) => element.id == model.data?.first.id);
        favorite.removeWhere((element) => element == model.data?.first.id);
        emit(AddToWishListFailure(l));
      }, (r) {
        emit(AddToWishListSuccess());
      });
    } else {
      emit(AddToWishListFailure(
          ApiErrorModel(message: 'No internet connection')));
    }
  }

  Future<void> getWishList() async {
    try {
      wishList = CachedApp.getCachedData(CachedDataType.wishList.name);
      emit(GetWishListSuccess());
    } catch (e) {
      emit(GetWishListLoading());
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (!connectivityResult.contains(ConnectivityResult.none)) {
        final response = await favRepo.getWishList();
        response.fold((l) => emit(GetWishListFailure(l)), (r) {
          favorite = [];
          wishList = r;
          for (var item in wishList) {
            favorite.add(item.id!);
          }
          CachedApp.saveData(wishList, CachedDataType.wishList.name);
          emit(GetWishListSuccess());
        });
        return;
      } else {
        Fluttertoast.showToast(
          msg: "No internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: ColorsManager.kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        emit(GetWishListFailure(
            ApiErrorModel(message: 'No internet connection')));
      }
    }
  }

  Future<void> removeFromWishList({required DataWish model}) async {
    emit(RemoveFromWishListLoading());
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (!connectivityResult.contains(ConnectivityResult.none)) {
      wishList.removeWhere((element) => element.id == model.id);
      favorite.removeWhere((element) => element == model.id);
      final response = await favRepo.removeFromWishList(productId: model.id!);
      response.fold((error) {
        wishList.add(model);
        favorite.add(model.id!);
        emit(RemoveFromWishListFailure(error));
      }, (profileData) {
        emit(RemoveFromWishListSuccess());
      });
    } else {
      emit(RemoveFromWishListFailure(
          ApiErrorModel(message: 'No internet connection')));
    }
  }
}
