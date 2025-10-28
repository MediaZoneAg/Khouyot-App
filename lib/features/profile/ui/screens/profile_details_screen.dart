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
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/profile/ui/widgets/profile_info_item.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Skeletonizer(
                    enabled: state is ProfileLoading,
                    child: Column(
                      children: [
                        CustomAppBar(
                            barIcon: Icons.arrow_back_ios,
                            onPressed: () {
                              context.pop();
                            },
                            title: S.of(context).Accountinfo),
                        verticalSpace(30),
                        CircleAvatar(
                            radius: 50.r,
                            backgroundImage:
                                const AssetImage(AssetsData.profileImage)),
                        verticalSpace(16),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).Name,
                                style: TextStyles.font16DarkgreyRegular,
                              ),
                              verticalSpace(5),
                              ProfileInfoItem(
                                content:
                                    '${ProfileCubit.get(context).profileModel?.name ?? ''}',
                              ),
                              verticalSpace(20),
                              Text(
                                S.of(context).Email,
                                style: TextStyles.font16DarkgreyRegular,
                              ),
                              verticalSpace(5),
                              ProfileInfoItem(
                                content:
                                    '${ProfileCubit.get(context).profileModel?.email ?? ''}',
                              ),
                              verticalSpace(34),
                              AppTextButton(
                                buttonText: S.of(context).Editaccount,
                                textStyle: TextStyles.font20WhiteMedium,
                                //verticalPadding: 3,
                                buttonHeight: 35.h,
                                borderRadius: 10.r,
                                onPressed: () {
                                  context
                                      .pushNamed(Routes.editAccountInfoScreen);
                                },
                                backgroundColor: ColorsManager.kPrimaryColor,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
