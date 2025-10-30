part of 'product_details_cubit.dart';

@immutable
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}
class SizeChanged1 extends ProductDetailsState{}
class ColorChanged1 extends ProductDetailsState{}
class ProductDetailsLoading extends ProductDetailsState{}
class ProductDetailsFail extends ProductDetailsState{}
class ProductDetailsSuccess extends ProductDetailsState{}
class ChangeImageIndex extends ProductDetailsState{}
