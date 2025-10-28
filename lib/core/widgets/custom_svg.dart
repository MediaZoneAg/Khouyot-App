import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';

class CustomSvg extends StatelessWidget {
  final String imgPath;
  final Color? color;
  final double? width;
  final double? height;
  const CustomSvg(
      {super.key, required this.imgPath, this.color, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SvgPicture.asset(
            width: 30.w,
            height: 30.h,
            imgPath,
            fit: BoxFit.scaleDown,
            color: color);
      },
    );
  }
}
