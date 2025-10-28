import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class CustomAppBar extends StatelessWidget {
  final IconData barIcon;
  final String title;
  final VoidCallback onPressed;
  const CustomAppBar(
      {super.key,
      required this.barIcon,
      required this.onPressed,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    barIcon,
                    size: 25,
                    color: ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.darkBlack
                        : ColorsManager.mainWhite,
                  )),
              Text(
                title,
                style: TextStyles.font18BlackMedium.copyWith(
                    color: ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? Colors.black
                        : ColorsManager.mainWhite),
              ),
            ],
          ),
        );
      },
    );
  }
}
