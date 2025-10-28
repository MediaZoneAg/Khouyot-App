import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class RequestStateUi extends StatelessWidget {
  const RequestStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartAllOrderLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is CartAllOrderSuccess) {
          Navigator.pop(context);
          context.pushNamedAndRemoveUntil(
            Routes.navigationBar,
            predicate: (Route<dynamic> route) => false,
          );
        } else if (state is CartAllOrderFailure) {
          Navigator.pop(context); // Close loading dialog
          ShowDialogError.showErrorDialog(context, S.of(context).error, state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
