
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/generated/l10n.dart';
class ResetPasswordStateUi extends StatelessWidget {
  const ResetPasswordStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is  ResetPasswordSuccess) {
          Navigator.pop(context);
          context.pushNamedAndRemoveUntil(
            Routes.signInScreen,
            predicate: (Route<dynamic> route) => false,
          );
        } else if (state is ResetPasswordFailure) {
          Navigator.pop(context);
          ShowDialogError.showErrorDialog(context, S.of(context).error, state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
