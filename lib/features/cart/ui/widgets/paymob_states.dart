import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';

class PayMobStates extends StatelessWidget {
  const PayMobStates({super.key});

  @override
 Widget build(BuildContext context) {
    return BlocListener<CartCubit,CartState>(
      listener: (context, state) async {
        if (state is PayMobLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const PopScope(
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorsManager.mainBlue,
                ),
              ),
            ),
          );
        }
        // Handle LoginSuccess state
        else if (state is PayMobSuccess) {

          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
            context.pushNamed(Routes.payMobScreen);
          }
        }

        // Handle LoginError and show the dialog here
        if (state is PayMobFailure) {
          Navigator.of(context).pop();
          ShowDialogError.showErrorDialog(
              context,
              "attention", // Pass the "attention" title here
              "Payment Failed",
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}