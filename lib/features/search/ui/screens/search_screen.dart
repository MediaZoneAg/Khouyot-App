import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/features/search/logic/search_cubit.dart';
import 'package:khouyot/features/search/ui/widgets/search_app_bar.dart';
import 'package:khouyot/generated/l10n.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20.w, left: 5.w),
                    child: SearchAppBar(
                      title: S.of(context).Search,
                      barIcon: Icons.arrow_back_ios,
                      onPressed: () => context.pop(),
                      onTap: () {
                        context.pushNamed(Routes.filterScreen);
                      },
                    ),
                  ),
                  verticalSpace(10),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: AppTextFormField(
                        hintText: S.of(context).Search,
                        borderRadius: 10.r,
                        hintStyle: TextStyles.font16DarkgreyRegular.copyWith(
                          color: ThemeCubit.get(context).themeMode ==
                                  ThemeMode.light
                              ? ColorsManager.darkGrey
                              : ColorsManager.lightGrey,
                        ),
                        onFieldSubmitted: (value) {
                          //if(value.isEmpty) return;
                          CashHelper.putString(
                              key: Keys.searchText, value: value);
                          context.pushNamed(Routes.searchResults);
                          SearchCubit.get(context).fetchSearchResults(value);
                        },
                        prefexIcon: SvgPicture.asset(
                          AssetsData.search,
                          fit: BoxFit.scaleDown,
                        )),
                  ),
                  verticalSpace(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      S.of(context).Lastestsearch,
                      style: TextStyles.font16BlackRegular.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? ColorsManager.black
                                : ColorsManager.mainWhite,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: 300.h,
                      child: ListView.builder(
                        itemBuilder: (context, index) => ListTile(
                          title: Text(
                              '${SearchCubit.get(context).searches[index]}'),
                          leading: const CustomSvg(
                            imgPath: AssetsData.clock,
                          ),
                          trailing:
                              InkWell(onTap: () {}, child: Icon(Icons.close)),
                        ),
                        itemCount: SearchCubit.get(context).searches.length,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
