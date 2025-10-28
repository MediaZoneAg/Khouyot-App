
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/show_dialog_error.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class EditProfileStateUi extends StatelessWidget {
  const EditProfileStateUi({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) async{
        if (state is EditProfileLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => const Center(
              child: CircularProgressIndicator(
                color: ColorsManager.kPrimaryColor,
              ),
            ),
          );
        } else if (state is EditProfileSuccess ) {
          Navigator.pop(context);
          ProfileCubit.get(context).fetchProfile();
          context.pushReplacementNamed(
            Routes.profileDetailsScreen,
          );
        } else if (state is EditProfileFailure) {
          Navigator.pop(context); // Close loading dialog
          ShowDialogError.showErrorDialog(context, S.of(context).error, state.error.message!);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
