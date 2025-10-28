
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/generated/l10n.dart';
class ChangePasswordStateUi extends StatelessWidget {
  const ChangePasswordStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ChangePasswordLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is  ChangePasswordSuccess) {
          Navigator.pop(context);
          context.pushNamedAndRemoveUntil(
            Routes.signInScreen,
            predicate: (Route<dynamic> route) => false,
          );
        } else if (state is ChangePasswordFailure) {
          Navigator.pop(context);
          ShowDialogError.showErrorDialog(context, S.of(context).error, state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
