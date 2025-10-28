part of 'category_cubit.dart';


abstract class CategoryState {}

final class CategoryInitial extends CategoryState {}

final class SubCategorySelected extends CategoryState {}

final class MainCategorySelected extends CategoryState {}

final class ChangePageBody extends CategoryState {}

final class ChangeContentBody extends CategoryState {}

final class ChangeSubContentBody extends CategoryState {}

final class CategoryLoading extends CategoryState {}

final class CategorySuccess extends CategoryState {}

final class CategoryFailure extends CategoryState {
  final ApiErrorModel error;
  CategoryFailure(this.error);
}

final class ChildCategoryLoading extends CategoryState {}

final class ChildCategorySuccess extends CategoryState {}

final class ChildCategoryFailure extends CategoryState {
  final ApiErrorModel error;
  ChildCategoryFailure(this.error);
}

final class ChildSubCategoryLoading extends CategoryState {}

final class ChildSubCategorySuccess extends CategoryState {}

final class ChildSubCategoryFailure extends CategoryState {
  final ApiErrorModel error;
  ChildSubCategoryFailure(this.error);
}

final class FetchProductSubSubCategoriesLoading extends CategoryState {}

final class FetchProductSubSubCategoriesSuccess extends CategoryState {}

final class FetchProductSubSubCategoriesFailure extends CategoryState {
  final ApiErrorModel error;
  FetchProductSubSubCategoriesFailure(this.error);
}

class ProductAllLoadingMore extends CategoryState {}

final class FetchMoreProductsSuccess extends CategoryState {
}
class OptionFilterChanged extends CategoryState {}

final class FetchMoreProductsFailure extends CategoryState {
  final ApiErrorModel error;
  FetchMoreProductsFailure( this.error);
}
