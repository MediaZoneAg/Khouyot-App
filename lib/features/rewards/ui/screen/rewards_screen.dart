import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/features/rewards/ui/widgets/rewards_offer.dart';
import 'package:khouyot/generated/l10n.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18.w, top: 60.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back, // استبدال barIcon بأيقونة مناسبة
                          size: 25,
                          color: ThemeCubit.get(context).themeMode ==
                                  ThemeMode.light
                              ? ColorsManager.darkBlack
                              : ColorsManager.mainWhite,
                        ),
                      ),
                      SizedBox(width: 50.w),
                      Text(
                        S.of(context).rewards,
                        style:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? TextStyles.font16darkBlackRegular
                                : TextStyles.font16WhiteRegular,
                      ),
                      SizedBox(width: 50.w),
                      Container(
                        width: 72.w,
                        height: 38.h,
                        decoration: BoxDecoration(
                          color: ThemeCubit.get(context).themeMode ==
                                  ThemeMode.light
                              ? ColorsManager.offWhite
                              : ColorsManager.darkBlack,
                          borderRadius: BorderRadius.circular(10.r),
                          boxShadow: [
                            BoxShadow(
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.lightGrey.withOpacity(0.5)
                                  : ColorsManager.blackGrey.withOpacity(0.5),
                              blurRadius: 12.r,
                              spreadRadius: 0,
                              offset: Offset(0, 0),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '160',
                              style: TextStyles.font16BlackRegular.copyWith(
                                color: ThemeCubit.get(context).themeMode ==
                                        ThemeMode.light
                                    ? ColorsManager.black
                                    : ColorsManager.mainWhite,
                              ),
                            ),
                            SizedBox(width: 5.w),
                            const CustomSvg(
                              imgPath: AssetsData.reward,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const RewardsOffer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
