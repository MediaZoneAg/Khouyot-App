part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class Increment extends CartState {}

final class Decrement extends CartState {}

final class CartItemSelected extends CartState {}

final class CartAllOrderLoading extends CartState {}

final class CartAllOrderSuccess extends CartState {}

final class CartAllOrderFailure extends CartState {
  final ApiErrorModel error;

  CartAllOrderFailure(this.error);
}

final class AddToCartState extends CartState {}
final class RemoveFromCartState extends CartState {}
final class CartItemsUpdatedState extends CartState {}

final class TotalPriceState extends CartState {
  final double total;

  TotalPriceState({required this.total});
}

final class ItemCount extends CartState {}

final class PaymentMethodSelected extends CartState {
  final String method;

  PaymentMethodSelected(this.method);
}

final class ChangeIndex extends CartState {}

final class CreditCardUpdated extends CartState {}

final class PaymentLoading extends CartState {}

final class PaymentSuccess extends CartState {}

final class PaymentFailure extends CartState {
  final ApiErrorModel error;
  PaymentFailure( this.error);
}
class PayMobSuccess extends CartState {}
class PayMobFailure extends CartState {}
class PayMobLoading extends CartState {}