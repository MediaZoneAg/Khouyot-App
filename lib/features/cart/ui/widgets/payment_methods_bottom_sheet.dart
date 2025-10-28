
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/widgets/payment_methods_list_view.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  bool isPaypal = false;

  updatePaymentMethod({required int index}) {
    if (index == 0) {
      isPaypal = false;
    } else {
      isPaypal = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<CartCubit>(),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 16,
            ),
            PaymentMethodsListView(
                //updatePaymentMethod: updatePaymentMethod,
                ),
            const SizedBox(
              height: 32,
            ),
            // CustomButtonBlocConsumer(
            //   isPaypal: isPaypal,
            // ),
          ],
        ),
      ),
    );
  }
}
