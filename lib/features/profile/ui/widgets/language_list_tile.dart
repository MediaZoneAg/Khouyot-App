import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/localization/cubit/localization_cubit.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/generated/l10n.dart';

class LanguageListTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return ListTile(
              title: Text(
                S.of(context).Language,
                style: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? TextStyles.font16BlackRegular
                    : TextStyles.font16WhiteRegular,
              ),
              
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      LocalizationCubit.get(context).locale.languageCode == 'en'
                          ? S.of(context).English
                          : S.of(context).Arabic,
                      style: TextStyles.font14DarkGreyRegular),
                      
                  horizontalSpace(10),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 20.sp,
                    color: ColorsManager.kPrimaryColor,
                  ),
                ],
              ),
              onTap: () async {
                await LocalizationCubit.get(context).toggleLanguage();
              },
            );
          },
        );
      },
    );
  }
}
