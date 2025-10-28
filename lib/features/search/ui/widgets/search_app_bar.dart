import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';

class SearchAppBar extends StatelessWidget {
  final IconData barIcon;
  final String title;
  final String? sufexIcon;
  final VoidCallback onPressed;
  final VoidCallback onTap;
  const SearchAppBar(
      {super.key,
      required this.barIcon,
      required this.onPressed,
      required this.title,
      this.sufexIcon,
      required this.onTap});

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
                    size: 25.sp,
                  )),
              Text(
                title,
                style: TextStyles.font18BlackMedium.copyWith(
                  color: ThemeCubit.get(context).themeMode == ThemeMode.light
                      ? ColorsManager.black
                      : ColorsManager.mainWhite,
                ),
              ),
              const Spacer(),
              InkWell(
                  onTap: onTap,
                  child: CustomSvg(
                    imgPath: sufexIcon ?? AssetsData.slider,
                    color: ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.darkBlack
                        : ColorsManager.mainWhite,
                  ))
            ],
          ),
        );
      },
    );
  }
}
