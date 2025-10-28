import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theme/ui/screen/theme_list_tile.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/features/profile/ui/widgets/country_list_tile.dart';
import 'package:khouyot/features/profile/ui/widgets/language_list_tile.dart';
import 'package:khouyot/features/profile/ui/widgets/setting_item_list_tile.dart';
import 'package:khouyot/generated/l10n.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      barIcon: Icons.arrow_back_ios,
                      onPressed: () {
                        context.pop();
                      },
                      title: S.of(context).Setting,
                    ),
                    SettingItemListTile(
                      title: S.of(context).SavedAddresses,
                      onTap: () {
                        context.pushNamed(Routes.savedAddressScreen);
                      },
                    ),
                    const Divider(),
                    SettingItemListTile(
                      title: S.of(context).ChangePassword,
                      onTap: () {
                        context.pushNamed(Routes.changePasswordScreen);
                      },
                    ),
                    const Divider(),
                    LanguageListTile(),
                    // const Divider(),
                    // const CountrylistTile(),
                    const Divider(),
                    const ThemeListTile(),
                    const Divider(),
                    SettingItemListTile(
                      title: S.of(context).Deleteaccount,
                      onTap: () {
                        context.pushNamed(Routes.deleteAccountScreen);
                      },
                    ),
                    const Divider(),
                    SettingItemListTile(
                      title: S.of(context).Logout,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              backgroundColor: ColorsManager.mainWhite,
                              title: Text(
                                S.of(context).confirmLogout,
                                style: TextStyles.font14DarkGreyRegular,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    S.of(context).Cancel,
                                    style: TextStyles.font14DarkGreyRegular,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    CashHelper.clear();
                                    DioFactory
                                        .removeTokenIntoHeaderAfterLogout();
                                    NavBarCubit.get(context)
                                        .changeIndex(0, jumping: false);
                                    context.pushNamedAndRemoveUntil(
                                      Routes.enteranceScreen,
                                      predicate: (Route<dynamic> route) =>
                                          false,
                                    );
                                  },
                                  child: Text(
                                    S.of(context).Logout,
                                    style: TextStyles.font14KprimaryRegular,
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                    const Divider(),
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
