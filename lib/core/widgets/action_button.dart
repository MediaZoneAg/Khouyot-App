import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key, required this.onTap, required this.iconContent});
  final VoidCallback onTap;
  final IconData iconContent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        //margin: EdgeInsets.symmetric(horizontal: 8.w),
        padding: const EdgeInsets.all(5),
        width: 35.w,
        height: 35.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
          border: Border.all(
            color: ColorsManager.offWhite,
            width: 1,
          ),
        ),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Icon(
              iconContent,
              color: ThemeCubit.get(context).themeMode == ThemeMode.light
                  ? ColorsManager.darkBlack
                  : ColorsManager.mainWhite,
            );
          },
        ),
      ),
    );
  }
}
