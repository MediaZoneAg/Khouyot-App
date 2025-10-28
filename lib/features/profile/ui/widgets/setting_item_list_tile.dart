import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class SettingItemListTile extends StatelessWidget {
  const SettingItemListTile(
      {super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return ListTile(
            title: Text(
              title,
              style: ThemeCubit.get(context).themeMode == ThemeMode.light
                  ? TextStyles.font16BlackRegular
                  : TextStyles.font16WhiteRegular,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 20.sp,
              color: ColorsManager.kPrimaryColor,
            ),
            onTap: onTap);
      },
    );
  }
}
