
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class DeleteAccountStateUi extends StatelessWidget {
  const DeleteAccountStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is  DeleteAccountLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is  DeleteAccountSuccess) {
          CashHelper.clear();
          Navigator.pop(context);
          context.pushNamedAndRemoveUntil(
            Routes.enteranceScreen,
            predicate: (Route<dynamic> route) => false,
          );
          Fluttertoast.showToast(
            msg: S.of(context).Accountdeletedsuccessfully,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: ColorsManager.kPrimaryColor,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is  DeleteAccountFailure) {
          Navigator.pop(context); // Close loading dialog
          ShowDialogError.showErrorDialog(context, S.of(context).error, state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
