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
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/profile/ui/screens/profile_guest_screen.dart';
import 'package:khouyot/features/profile/ui/widgets/profile_items_list_tile.dart';
import 'package:khouyot/features/profile/ui/widgets/profile_list_title.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    ProfileCubit.get(context).fetchProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CashHelper.getBool(key: Keys.guestMode) == true
        ? const ProfileGuestScreen()
        : BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor:
                    ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.mainWhite
                        : ColorsManager.kSecondaryColor,
                body: SafeArea(
                    child: Padding(
                  padding:
                      EdgeInsets.only(right: 16.w, left: 16.0.w, top: 20.h),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await ProfileCubit.get(context).fetchProfile();
                    },
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16.0.w, top: 10.h),
                          child: Text(
                            S.of(context).Profile,
                            style: TextStyles.font18BlackMedium.copyWith(
                                color: ThemeCubit.get(context).themeMode ==
                                        ThemeMode.light
                                    ? Colors.black
                                    : ColorsManager.mainWhite),
                          ),
                        ),
                        verticalSpace(20),
                        const ProfileListTile(),
                        verticalSpace(20),
                        ProfileItemListTile(
                          title: S.of(context).Notifications,
                          onTap: () {
                            context.pushNamed(Routes.notificationScreen);
                          },
                          img: AssetsData.notification,
                        ),
                        const Divider(),
                        ProfileItemListTile(
                          title: S.of(context).Orders,
                          onTap: () {
                            context.pushNamed(Routes.ordersScreen);
                          },
                          img: AssetsData.orders,
                        ),
                        const Divider(),
                        ProfileItemListTile(
                          title: S.of(context).WishList,
                          onTap: () {
                            context.pushNamed(Routes.wishListScreen);
                          },
                          img: AssetsData.favriote,
                        ),
                        const Divider(),
                        ProfileItemListTile(
                          title: S.of(context).GetHelp,
                          onTap: () {
                            context.pushNamed(Routes.chatScreen);
                          },
                          img: AssetsData.getHelp,
                        ),
                        // const Divider(),
                        // ProfileItemListTile(
                        //   title: S.of(context).TermsConditions,
                        //   onTap: () {},
                        //   img: AssetsData.termsConditions,
                        // ),
                        const Divider(),

                        ProfileItemListTile(
                          title: S.of(context).TermsConditions,
                          onTap: () async {
                            final Uri url = Uri.parse(
                                'https://www.khoyoutscarfstores.com/privacy-policy/');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url,
                                  mode: LaunchMode.externalApplication);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          img: AssetsData.termsConditions,
                        ),

                        // const Divider(),
                        // ProfileItemListTile(
                        //   title: S.of(context).AboutApp,
                        //   onTap: () {},
                        //   img: AssetsData.aboutApp,
                        // ),
                        const Divider(),
                        ProfileItemListTile(
                          title: S.of(context).Setting,
                          onTap: () {
                            context.pushNamed(Routes.settingScreen);
                          },
                          img: AssetsData.setting,
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                )),
              );
            },
          );
  }
}
