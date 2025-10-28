import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';


class CategoryAppBar extends StatelessWidget {
  const CategoryAppBar({
    super.key,
    required this.title,
    this.width,
    this.content,
    this.btn1,
    this.btn2,
    this.onTap1,
    this.onTap2,
    this.onTap3,
  });
  final String title;
  final double? width;
  final Widget? content;
  final Widget? btn1;
  final Widget? btn2;
  final void Function()? onTap1;
  final void Function()? onTap2;
  final void Function()? onTap3;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Row(
          children: [
            // InkWell(
            //     onTap: onTap1 ?? () {},
            //     child: content ??
            //         //
            //         ),
            horizontalSpace(width ?? 100),
            Text(
              title,
              style: TextStyles.font16BlackRegular.copyWith(
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? ColorsManager.darkBlack
                    : ColorsManager.mainWhite,
              ),
            ),
            horizontalSpace(width ?? 90),
            // InkWell(
            //     onTap: onTap2 ?? () {},
            //     child: btn1 ??
            //         const CustomSvg(
            //           imgPath: AssetsData.search,
            //           color: ColorsManager.kPrimaryColor,
            //         )),
            // horizontalSpace(15),
            // InkWell(
            //     onTap: onTap3 ?? () {},
            //     child: btn2 ??
            //         const CustomSvg(
            //           imgPath: AssetsData.favriote,
            //         )),
          ],
        );
      },
    );
  }
}
