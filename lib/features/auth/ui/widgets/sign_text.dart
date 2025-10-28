import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class SignText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextStyle? style;
  const SignText({super.key, required this.text, this.color, this.style});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                indent: 10.0,
                endIndent: 10.0,
                thickness: 1,
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? ColorsManager.black
                    : ColorsManager.mainWhite,
              ),
            ),
            Text(
              text,
              style: style ??
                  TextStyles.font16BlackRegular.copyWith(
                    color: ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.black
                        : ColorsManager.mainWhite,
                  ),
            ),
            Expanded(
              child: Divider(
                indent: 10.0,
                endIndent: 10.0,
                thickness: 1,
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? ColorsManager.black
                    : ColorsManager.mainWhite,
              ),
            ),
          ],
        );
      },
    );
  }
}
