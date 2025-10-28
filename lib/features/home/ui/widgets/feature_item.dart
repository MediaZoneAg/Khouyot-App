import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class FeatureItem extends StatelessWidget {
  final bool isSelected;
  final String name;
  final VoidCallback onTap;

  const FeatureItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 44.h,
        decoration: BoxDecoration(
          color: isSelected
              ? ColorsManager.kPrimaryColor
              : (ThemeCubit.get(context).themeMode == ThemeMode.light
                  ? ColorsManager.mainWhite
                  : ColorsManager.darkBlack),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ThemeCubit.get(context).themeMode == ThemeMode.light
                ? ColorsManager.offWhite
                : ColorsManager.darkBlack,
          ),
        ),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Center(
              child: Text(
                name,
                style: isSelected
                    ? TextStyles.font16WhiteRegular
                    : TextStyles.font16BlackRegular.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? ColorsManager.black
                                : ColorsManager.mainWhite),
              ),
            );
          },
        ),
      ),
    );
  }
}
