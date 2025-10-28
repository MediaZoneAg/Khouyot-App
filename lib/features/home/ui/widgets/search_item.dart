import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/generated/l10n.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Row(
          children: [
            // SizedBox(
            //   width: 270.w,
            //   height: 50.h,
            //   child: AppTextFormField(
            //     hintText: S.of(context).Search,
            //     hintStyle: TextStyles.font16DarkgreyRegular,
            //     readOnly: true,
            //     contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            //     onTap: () {
            //       context.pushNamed(Routes.searchScreen);
            //     },
            //     borderRadius: 10.r,
            //     focusedBorder: OutlineInputBorder(
            //       borderSide:  BorderSide(
            //         color: ColorsManager.grey,
            //         width: 1.3.w,
            //       ),
            //       borderRadius: BorderRadius.circular(10.0.r),
            //     ),
            //     prefexIcon: const CustomSvg(imgPath: AssetsData.search),
            //     suffixIcon: const CustomSvg(imgPath: AssetsData.slider),
            //   ),
            // ),
            //  const Spacer(), // Adding spacing between widgets
            SizedBox(
              width: 10.w,
            ),
            InkWell(
              onTap: () async {
                if (await CashHelper.getStringSecured(key: Keys.token) != '') {
                  context.pushNamed(Routes.searchScreen);
                } else {
                  showSnackBar(
                      context:
                          NavigationService.navigatorKey.currentState!.context,
                      text: S.of(context).Youneedtologinfirst);
                }
              },
              child: CustomSvg(
                imgPath: AssetsData.searchBlack,
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? ColorsManager.black
                    : ColorsManager.mainWhite,
              ),
            ),
            SizedBox(
              width: 15.w,
            ),
            InkWell(
              onTap: () async {
                if (await CashHelper.getStringSecured(key: Keys.token) != '') {
                  context.pushNamed(Routes.wishListScreen);
                } else {
                  showSnackBar(
                      context:
                          NavigationService.navigatorKey.currentState!.context,
                      text: S.of(context).Youneedtologinfirst);
                }
              },
              child: CustomSvg(
                imgPath: AssetsData.favriote,
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? ColorsManager.black
                    : ColorsManager.mainWhite,
              ),
            ),
            // SizedBox(
            //   width: 135.w,
            // ),
            // InkWell(
            //   onTap: () async {
            //     if (await CashHelper.getStringSecured(key: Keys.token) != '') {
            //       // context.pushNamed(Routes.notificationScreen);
            //     } else {
            //       showSnackBar(
            //           context:
            //               NavigationService.navigatorKey.currentState!.context,
            //           text: S.of(context).Youneedtologinfirst);
            //     }
            //   },
            //   child: GestureDetector(
            //     onTap: () {
            //       Navigator.pushNamed(context, Routes.rewardsScreen);
            //     },
            //     child: Container(
            //       width: 72.w,
            //       height: 38.h,
            //       decoration: BoxDecoration(
            //         color: ThemeCubit.get(context).themeMode == ThemeMode.light
            //             ? ColorsManager.offWhite
            //             : ColorsManager.darkBlack,
            //         borderRadius: BorderRadius.circular(10.r),
            //         boxShadow: [
            //           BoxShadow(
            //             color:
            //                 ThemeCubit.get(context).themeMode == ThemeMode.light
            //                     ? ColorsManager.lightGrey.withOpacity(0.5)
            //                     : ColorsManager.blackGrey.withOpacity(0.5),

            //             blurRadius: 12.r,
            //             spreadRadius: 0,
            //             offset: Offset(0, 0), // No horizontal or vertical shift
            //           ),
            //         ],
            //       ),
            //       child: Row(
            //         children: [
            //           SizedBox(
            //             width: 10.w,
            //           ),
            //           Center(
            //             child: Text(
            //               '160',
            //               style: TextStyles.font16BlackRegular.copyWith(
            //                   color: ThemeCubit.get(context).themeMode ==
            //                           ThemeMode.light
            //                       ? ColorsManager.black
            //                       : ColorsManager.mainWhite),
            //             ),
            //           ),
            //           const CustomSvg(
            //             imgPath: AssetsData.reward,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   width: 10.w,
            // ),
            // InkWell(
            //   onTap: () async {
            //     if (await CashHelper.getStringSecured(key: Keys.token) != '') {
            //       context.pushNamed(Routes.notificationScreen);
            //     } else {
            //       showSnackBar(
            //           context:
            //               NavigationService.navigatorKey.currentState!.context,
            //           text: S.of(context).Youneedtologinfirst);
            //     }
            //   },
            //   child: CustomSvg(
            //     imgPath: AssetsData.notification,
            //     color: ThemeCubit.get(context).themeMode == ThemeMode.light
            //         ? ColorsManager.black
            //         : ColorsManager.mainWhite,
            //   ),
            // ),
          ],
        );
      },
    );
  }
}
