import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/features/cart/data/models/cartt_model.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/errors/api_error_model.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/cart/data/models/billing_model.dart';
import 'package:khouyot/features/cart/data/models/cart_item_model.dart';
import 'package:khouyot/features/cart/data/models/cart_model.dart';
import 'package:khouyot/features/cart/data/models/line_item.dart';
import 'package:khouyot/features/cart/data/models/order_model.dart';
import 'package:khouyot/features/cart/data/models/shipping_model.dart';
import 'package:khouyot/features/cart/data/repos/cart_repo.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:meta/meta.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit(this.cartRepo) : super(CartInitial());
  final CartRepo cartRepo;
  static CartCubit get(context) => BlocProvider.of(context);
  int num = 1;
  CartModel? selectedItem;
  int index = 0;
  String cardNumber = '', expiryDate = '', cardHolderName = '', cvvCode = '';
  bool showBackView = false;
  List<CartItemModel> cartItemList = [];
  late OrderModel orderModel;
  late Shipping shipping;
  late Billing billing;
  late List<LineItems> lineItems;
  double total = 0.0;
  String? paymentKey;
  CartResponse? cartResponse;
  Future<void> getCart()async{
    print('cart');
    emit(GetCartLoading());
    var response =await cartRepo.getCart();
    response.fold((l){emit(GetCartFail());}, (r){
      cartResponse=r;
      emit(GetCartSuccess());});
  }
  void totalPrice() {
    // total = 0.0;
    // for (int i = 0; i < cartItemList.length; i++) {
    //   // Ensure the price is parsed correctly from String to double
    //   total += double.parse(cartItemList[i].productModel.data!.variants.first.price) *
    //       cartItemList[i].quantity;
    // }
    // emit(TotalPriceState(total: total));
  }

  final List<CartModel> cartList = [
    CartModel(
      id: 1,
      name: 'Product 1',
      price: 100,
      imageUrl: AssetsData.cat2,
      size: 'small',
      color: 'black',
    ),
    CartModel(
      id: 2,
      name: 'Product 2',
      price: 200,
      imageUrl: AssetsData.cat3,
      size: 'small',
      color: 'green',
    ),
    CartModel(
      id: 2,
      name: 'Product 3',
      price: 300,
      imageUrl: AssetsData.cat1,
      size: 'small',
      color: 'green',
    ),
  ];
  void increment() {
    num += 1;
    emit(Increment());
  }

  void decrement() {
    if (num > 1) {
      // Optional: Prevent num from going below 1
      num -= 1;
      emit(Decrement());
    }
  }

  void selectItem(CartModel item) {
    selectedItem = item;
    emit(CartItemSelected());
  }

  void clearCart() {
    cartItemList.clear();
    emit(CartItemsUpdatedState()); // Emit a state to notify the UI
  }

  void addToCart(CartItemModel product) {
    // if (cartItemList.any((element) =>
    //     element.productModel.data?.id == product.productModel.data?.id &&
    //     element.variantId == product.variantId)) {
    //   int index = cartItemList.indexWhere((element) =>
    //       element.productModel.data?.id == product.productModel.data?.id &&
    //       element.variantId == product.variantId);
    //   if (product.quantity > 1) {
    //     cartItemList[index].quantity += product.quantity;
    //   } else {
    //     cartItemList[index].quantity++;
    //   }
    //   emit(AddToCartState());
    //   showSnackBar(
    //       context: NavigationService.navigatorKey.currentState!.context,
    //       text: S
    //           .of(NavigationService.navigatorKey.currentState!.context)
    //           .SuccessfullyAddedToCart);
    //   return;
    // }
    // cartItemList.add(product);
    // showSnackBar(
    //     context: NavigationService.navigatorKey.currentState!.context,
    //     text: S
    //         .of(NavigationService.navigatorKey.currentState!.context)
    //         .SuccessfullyAddedToCart);
    // emit(AddToCartState());
    // totalPrice();
  }

  void removeFromCart(CartItemModel product) {
    // cartItemList.removeWhere((element) =>
    //     element.productModel.data?.id == product.productModel.data?.id&&
    //     element.variantId == product.variantId);
    // emit(RemoveFromCartState());
    // totalPrice(); // Recalculate the total after removing
  }

  void changeItemCountPlus(int index) {
    cartItemList[index].quantity += 1;
    emit(ItemCount());
    totalPrice(); // Recalculate the total after quantity change
  }

  void changeItemCountRemove(int index) {
    if (cartItemList[index].quantity > 0) {
      cartItemList[index].quantity -= 1;
      emit(ItemCount());
      totalPrice(); // Recalculate the total after quantity change
    }
  }

  String? selectedPaymentMethod;

  void selectPaymentMethod(String method) {
    selectedPaymentMethod = method;
    emit(PaymentMethodSelected(method));
  }

  Future<void> placeOrder() async {
    emit(CartAllOrderLoading());
    var result = await cartRepo.placeOrder(orderModel);
    result.fold(
      (failure) {
        ShowDialogError.showErrorDialog(
            NavigationService.navigatorKey.currentContext!,
            "attention",
            failure.message!);
        emit(CartAllOrderFailure(failure));
      },
      (response) async {
        cartItemList = [];
        emit(CartAllOrderSuccess());
      },
    );
  }

  void changeIndexPaymentMeathod(int newIndex) {
    index = newIndex;
    emit(ChangeIndex());
  }

  Future<void> pay(double amount, Billing billing) async {
    emit(PayMobLoading());
    var result = await cartRepo.payWithPayMob(amount, billing);
    result.fold((failure) => emit(PayMobFailure()), (response) {
      paymentKey = response;
      print('paymentKey ${response}');
      emit(PayMobSuccess());
    });
  }

  // Future makePayment(
  //     {required PaymentIntentInputModel paymentIntentInputModel}) async {
  //   emit(PaymentLoading());

  //   var data = await checkoutRepo.makePayment(
  //       paymentIntentInputModel: paymentIntentInputModel);

  //   data.fold(
  //     (l) => emit(PaymentFailure(l.errMessage)),
  //     (r) => emit(
  //       PaymentSuccess(),
  //     ),
  //   );
  // }

  @override
  void onChange(Change<CartState> change) {
    //log(change.toString());
    super.onChange(change);
  }

  void updateCreditCardDetails({
    required String number,
    required String expiry,
    required String holderName,
    required String cvv,
    required bool isCvvFocused,
  }) {
    cardNumber = number;
    expiryDate = expiry;
    cardHolderName = holderName;
    cvvCode = cvv;
    showBackView = isCvvFocused;
    emit(CreditCardUpdated());
  }
}
