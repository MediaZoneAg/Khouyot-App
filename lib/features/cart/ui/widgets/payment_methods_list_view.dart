import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/widgets/payment_method_item.dart';

class PaymentMethodsListView extends StatefulWidget {
  const PaymentMethodsListView({
    super.key,
  });

  //final Function({required int index}) updatePaymentMethod;
  @override
  State<PaymentMethodsListView> createState() => _PaymentMethodsListViewState();
}

class _PaymentMethodsListViewState extends State<PaymentMethodsListView> {
  final List<String> paymentMethodsItems = const [
    'assets/images/card_image.svg',
    'assets/images/paypal.svg'
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return SizedBox(
          height: 58.h,
          child: ListView.builder(
              itemCount: paymentMethodsItems.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      CartCubit.get(context).changeIndexPaymentMeathod(index);
                      //widget.updatePaymentMethod(index: activeIndex);
                    },
                    child: PaymentMethodItem(
                      isActive: CartCubit.get(context).index == index,
                      image: paymentMethodsItems[index],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
