import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/features/search/ui/widgets/category.dart';
import 'package:khouyot/features/search/ui/widgets/filter_buttons.dart';
import 'package:khouyot/generated/l10n.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          bottomNavigationBar: FilterButtons(
            text1: S.of(context).Apply,
            text2: S.of(context).reset,
            onTap1: () {
              context.pop();
            },
            onTap2: () {},
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                        barIcon: Icons.arrow_back_ios,
                        onPressed: () => context.pop(),
                        title: S.of(context).filter),
                    verticalSpace(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10),
                          Text(
                            S.of(context).Category,
                            style: TextStyles.font18BlackMedium.copyWith(
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.black
                                  : ColorsManager.mainWhite,
                            ),
                          ),
                          verticalSpace(15),
                          const Category(),
                          verticalSpace(40),
                          Text(
                            S.of(context).PriceRange,
                            style: TextStyles.font18BlackMedium.copyWith(
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.black
                                  : ColorsManager.mainWhite,
                            ),
                          ),
                          verticalSpace(15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 40.h,
                                width: 155.w,
                                child: AppTextFormField(
                                    borderRadius: 10,
                                    hintText: S.of(context).MinPrice,
                                    hintStyle: TextStyles.font16Grey),
                              ),
                              SizedBox(
                                height: 40.h,
                                width: 155.w,
                                child: AppTextFormField(
                                    borderRadius: 10,
                                    hintText: S.of(context).MaxPrice,
                                    hintStyle: TextStyles.font16Grey),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
