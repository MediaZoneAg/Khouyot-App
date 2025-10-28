import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';

class SignWithItem extends StatelessWidget {
  final String logoIcon;
  final VoidCallback onPressed;
  final double? size;
  const SignWithItem(
      {super.key, required this.logoIcon, required this.onPressed, this.size});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          width: 55.w,
          height: 55.h,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? ColorsManager.grey
                    : ColorsManager.mainWhite,
              )),
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: onPressed,
            child: CustomSvg(
              imgPath: logoIcon,
              color: ThemeCubit.get(context).themeMode == ThemeMode.light
                  ? ColorsManager.black
                  : ColorsManager.mainWhite,
            ),
          ),
        );
      },
    );
  }
}
