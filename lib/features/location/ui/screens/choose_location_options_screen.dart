import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/generated/l10n.dart';

class ChooseLocationOptionsScreen extends StatelessWidget {
  const ChooseLocationOptionsScreen({super.key});

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
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Column(
                children: [
                  CustomAppBar(
                      barIcon: Icons.arrow_back_ios,
                      onPressed: () {
                        context.pop();
                      },
                      title: S.of(context).back),
                  verticalSpace(90),
                  const CustomSvg(
                    imgPath: AssetsData.loccation,
                  ),
                  verticalSpace(30),
                  Text(
                    S.of(context).WhatsYourLocation,
                    style: TextStyles.font28BlackMedium.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? Colors.black
                                : ColorsManager.mainWhite),
                  ),
                  verticalSpace(10),
                  SizedBox(
                    width: 270.w,
                    child: Text(
                      S.of(context).WhatsYourLocationDes,
                      style: TextStyles.font16DarkgreyRegular,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpace(60),
                  AppTextButton(
                    buttonText: S.of(context).AllowlocationAccess,
                    textStyle: TextStyles.font20WhiteMedium,
                    onPressed: () {
                      //context.pushReplacementNamed(Routes.detailsScreen);
                    },
                    buttonWidth: 330,
                    backgroundColor: ColorsManager.kPrimaryColor,
                    //verticalPadding: 10,
                    buttonHeight: 54,
                    borderRadius: 10,
                  ),
                  verticalSpace(8),
                  AppTextButton(
                    buttonText: S.of(context).Addlocationmanually,
                    textStyle: TextStyles.font20KprimaryMedium,
                    onPressed: () {
                      context.pushReplacementNamed(Routes.locationManualScreen);
                    },
                    buttonWidth: 330,
                    buttonHeight: 54,
                    borderRadius: 10.r,
                    backgroundColor: Colors.transparent,
                    //verticalPadding: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
