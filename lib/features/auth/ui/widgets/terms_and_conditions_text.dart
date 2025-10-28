import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/generated/l10n.dart';
import '../../../../core/theming/styles.dart';

class TermsAndConditionsText extends StatefulWidget {
  const TermsAndConditionsText({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  State<TermsAndConditionsText> createState() => _TermsAndConditionsTextState();
}

class _TermsAndConditionsTextState extends State<TermsAndConditionsText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Checkbox(
              activeColor: ColorsManager.grey,
              checkColor: ColorsManager.kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              value: AuthCubit.get(context).isChecked,
              onChanged: (newValue) {
                AuthCubit.get(context).changeCheckboxValue(newValue!);
              },
            );
          },
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: S.of(context).Agreewith,
                style: TextStyles.font14DarkGreyRegular,
              ),
              TextSpan(
                text: S.of(context).TermsConditions,
                style: TextStyles.font14KprimaryRegular.copyWith(
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()..onTap = widget.onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
