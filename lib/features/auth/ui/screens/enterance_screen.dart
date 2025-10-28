import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_text.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_with_body.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class EnteranceScreen extends StatelessWidget {
  const EnteranceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          body: SafeArea(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 15.0.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: AppTextButton(
                        buttonText: S.of(context).ImaGuest,
                        textStyle: TextStyles.font16DarkerGreyRegular.copyWith(
                          color: ThemeCubit.get(context).themeMode ==
                                  ThemeMode.light
                              ? ColorsManager.darkerGrey
                              : ColorsManager.kPrimaryColor,
                        ),
                        onPressed: () {
                          CashHelper.putBool(key: Keys.guestMode, value: true);
                          NavBarCubit.get(context)
                              .changeIndex(0, jumping: false);
                          context.pushNamed(
                            Routes.navigationBar,
                          );
                        },
                        backgroundColor: ColorsManager.lighKPrimaryColor,
                        buttonWidth: 119.w,
                        buttonHeight: 35.h,
                        //verticalPadding: 4.h,
                        borderRadius: 10.r,
                      ),
                    ),
                    verticalSpace(65),
                    SizedBox(
                      width: 330.w,
                      child: RichText(
                          text: TextSpan(
                        text: S.of(context).WelcomeTo,
                        style: TextStyles.font36BlackBold.copyWith(
                          color: ThemeCubit.get(context).themeMode ==
                                  ThemeMode.light
                              ? ColorsManager.black
                              : ColorsManager.mainWhite,
                        ),
                        // .copyWith(
                        //   height: 1.4.h,
                        // ),
                        children: [
                          TextSpan(
                              text: S.of(context).Khoyout,
                              style: TextStyles.font36KprimaryBold
                                  .copyWith(letterSpacing: 1.sp)),
                        ],
                      )),
                    ),
                    verticalSpace(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 11.0),
                      child: Text(
                        S.of(context).KhoyoutDes,
                        style: TextStyles.font16DarkerGreyRegular
                            .copyWith(letterSpacing: 0.2.sp),
                      ),
                    ),
                    verticalSpace(50),
                    AppTextButton(
                      buttonText: S.of(context).SignUp,
                      onPressed: () {
                        context.pushNamed(Routes.signUpScreen);
                      },
                      backgroundColor: ColorsManager.kPrimaryColor,
                      buttonWidth: 311.w,
                      buttonHeight: 40.h,
                      borderRadius: 10.r,
                      textStyle: TextStyles.font20WhiteMedium,
                    ),
                    verticalSpace(24),
                    AppTextButton(
                      buttonText: S.of(context).SignIn,
                      onPressed: () {
                        context.pushNamed(Routes.signInScreen);
                      },
                      backgroundColor:
                          ThemeCubit.get(context).themeMode == ThemeMode.light
                              ? Colors.transparent
                              : ColorsManager.kSecondaryColor,
                      borderColor: ColorsManager.kPrimaryColor,
                      buttonWidth: 311.w,
                      buttonHeight: 40.h,
                      borderRadius: 10.r,
                      textStyle: TextStyles.font20KprimaryMedium,
                    ),
                    verticalSpace(38),
                    SignText(
                      text: S.of(context).Orbysocialaccounts,
                      color: ColorsManager.darkGrey,
                      style: TextStyles.font16DarkgreyRegular.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? ColorsManager.darkGrey
                                : ColorsManager.mainWhite,
                      ),
                    ),
                    verticalSpace(20),
                    const SignWithBody(),
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
