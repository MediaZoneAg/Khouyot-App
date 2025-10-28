part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class ChangePageBody extends HomeState {}

class ChangeImageIndex extends HomeState {}

class AddToFavriot extends HomeState {}

class ChangeId extends HomeState {}

class ColorChanged1 extends HomeState {}

class SizeChanged1 extends HomeState {}

class ColorChanged2 extends HomeState {}

class SizeChanged2 extends HomeState {}

class ColorChanged3 extends HomeState {}

class SizeChanged3 extends HomeState {}


final class Increment extends HomeState {}

final class Decrement extends HomeState {}

final class ProductAllSuccess extends HomeState {
}

final class ProductAllLoading extends HomeState {}

class ProductAllLoadingMore extends HomeState {}

final class FetchMoreProductsSuccess extends HomeState {
}

final class FetchMoreProductsFailure extends HomeState {
  final ApiErrorModel error;
  FetchMoreProductsFailure( this.error);
}

final class MoreProductSpecificLoading extends HomeState {}

class MoreProductSpecificSuccess extends HomeState {}

final class MoreProductSpecificFailure extends HomeState {
  final ApiErrorModel error;
  MoreProductSpecificFailure( this.error);
}

final class ProductAllFailure extends HomeState {
  final ApiErrorModel error;
  ProductAllFailure( this.error);
}

final class FetchProductAtSpecificCategoriesLoading extends HomeState {}

final class FetchProductAtSpecificCategoriesSuccess extends HomeState {

}

final class FetchProductAtSpecificCategoriesFailure extends HomeState {
  final ApiErrorModel error;
  FetchProductAtSpecificCategoriesFailure( this.error);
}
final class FilterCategoriesLoaded extends HomeState {}
final class FilterCategorySelected extends HomeState {}



