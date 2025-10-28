import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/generated/l10n.dart';

class ThemeListTile extends StatelessWidget {
  const ThemeListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return GestureDetector(
            onTap: () async {
              await ThemeCubit.get(context).toggleTheme();
            },
            child: ListTile(
              title: Text(
                S.of(context).theme,
                style: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? TextStyles.font16BlackRegular
                    : TextStyles.font16WhiteRegular,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      ThemeCubit.get(context).themeMode == ThemeMode.light
                          ? S.of(context).light
                          : S.of(context).dark,
                      style: TextStyles.font14DarkGreyRegular.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? ColorsManager.darkGrey
                                : ColorsManager.darkGrey,
                      )),
                  horizontalSpace(10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: ColorsManager.kPrimaryColor,
                  ),
                ],
              ),
            ));
      },
    );
  }
}










       