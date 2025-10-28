import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import '../../../../core/theming/styles.dart';

class DontHaveAccountText extends StatelessWidget {
  final String text1;
  final String text2;
  final VoidCallback onTap;
  const DontHaveAccountText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: text1,
                style: TextStyles.font16BlackRegular.copyWith(
                  color: ThemeCubit.get(context).themeMode == ThemeMode.light
                      ? ColorsManager.black
                      : ColorsManager.mainWhite,
                ),
              ),
              TextSpan(
                text: text2,
                style: TextStyles.font16KprimaryRegular
                    .copyWith(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()..onTap = onTap,
              ),
            ],
          ),
        );
      },
    );
  }
}
