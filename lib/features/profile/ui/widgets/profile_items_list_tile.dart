import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';

class ProfileItemListTile extends StatelessWidget {
  const ProfileItemListTile(
      {super.key,
      required this.title,
      this.onTap,
      required this.img,
      this.color});
  final String title;
  final VoidCallback? onTap;
  final String img;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
          leading: CustomSvg(
            imgPath: img,
            color: color ?? ColorsManager.kPrimaryColor,
          ),
          title: Text(
            title,
            style: TextStyles.font16BlackRegular.copyWith(
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? Colors.black
                    : ColorsManager.mainWhite),
          ),
          onTap: onTap,
        );
      },
    );
  }
}
