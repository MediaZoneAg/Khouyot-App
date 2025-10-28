import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/features/search/ui/widgets/search_app_bar.dart';
import 'package:khouyot/features/search/ui/widgets/search_grid_view.dart';
import 'package:khouyot/generated/l10n.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 20.w, left: 5.w),
                  child: SearchAppBar(
                    title: S.of(context).SearchResults,
                    barIcon: Icons.arrow_back_ios,
                    onPressed: () => context.pop(),
                    onTap: () {
                      context.pop();
                    },
                  ),
                ),
                verticalSpace(10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: AppTextFormField(
                    hintText: CashHelper.getString(key: Keys.searchText) ??
                        S.of(context).Search,
                    borderRadius: 10.r,
                    readOnly: true,
                    onTap: () {
                      context.pop();
                    },
                    hintStyle: TextStyles.font16BlackRegular,
                    prefexIcon: const CustomSvg(
                      imgPath: AssetsData.search,
                    ),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(
                    left: 25.w,
                    right: 25.w,
                    top: 10.h,
                  ),
                  child: const SearchGridView(),
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}
