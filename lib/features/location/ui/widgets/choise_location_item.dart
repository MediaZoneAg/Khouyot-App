import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class ChoiseLocationItem extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String title;

  const ChoiseLocationItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 60.h,
            decoration: BoxDecoration(
              color: isSelected ? ColorsManager.darkBlue : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: isSelected ? Colors.transparent : ColorsManager.grey),
            ),
            child: Text(
              title,
              style: isSelected
                  ? TextStyles.font16WhiteRegular
                  : TextStyles.font16BlackRegular.copyWith(
                      color:
                          ThemeCubit.get(context).themeMode == ThemeMode.light
                              ? Colors.black
                              : ColorsManager
                                  .mainWhite), // Different style if needed
            ),
          ),
        );
      },
    );
  }
}
