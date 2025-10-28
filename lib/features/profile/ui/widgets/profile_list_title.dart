import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/error_container.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/profile/ui/widgets/ui_loading_profile.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProfileListTile extends StatelessWidget {
  const ProfileListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Skeletonizer(
            enabled: true,
            child: UiLoadingProfile(),
          );
        }
        if (ProfileCubit.get(context).profileModel != null) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return ListTile(
                leading: CircleAvatar(
                    radius: 30.r,
                    backgroundImage: const AssetImage(AssetsData.profileImage)),
                title: Text(
                  ProfileCubit.get(context).profileModel!.name,
                  style: TextStyles.font16BlackRegular.copyWith(
                      color:
                          ThemeCubit.get(context).themeMode == ThemeMode.light
                              ? Colors.black
                              : ColorsManager.mainWhite),
                ),
                subtitle: Text(
                  ProfileCubit.get(context).profileModel!.email,
                  style: TextStyles.font16DarkgreyRegular.copyWith(
                      color:
                          ThemeCubit.get(context).themeMode == ThemeMode.light
                              ? ColorsManager.darkGrey
                              : ColorsManager.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20.sp,
                ),
                onTap: () {
                  ProfileCubit.get(context).profileModel != null
                      ? context.pushNamed(Routes.profileDetailsScreen)
                      : {};
                },
              );
            },
          );
        }
        return const ErrorContainer();
      },
    );
  }
}
