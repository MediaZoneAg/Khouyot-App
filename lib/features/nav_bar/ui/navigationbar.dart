import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class NavigationBarApp extends StatefulWidget {
  const NavigationBarApp({super.key});

  @override
  State<NavigationBarApp> createState() => _NavigationBarAppState();
}

class _NavigationBarAppState extends State<NavigationBarApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, NavBarState>(
      builder: (context, state) {
        log("hhhhh${NavBarCubit.get(context).selectedIndex.toString()}");
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: ColorsManager.mainWhite,
              body: PageView(
                controller: NavBarCubit.get(context).pageController,
                children: NavBarCubit.get(context).screens,
                onPageChanged: (index) {
                  NavBarCubit.get(context).changeIndex(index, jumping: false);
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor:
                    ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.mainWhite
                        : ColorsManager.kSecondaryColor,
                iconSize: 24.sp,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: ColorsManager.kPrimaryColor,
                unselectedItemColor: ColorsManager.grey,
                // selectedLabelStyle: TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 15.sp,
                // ),
                currentIndex: NavBarCubit.get(context).selectedIndex,
                onTap: (index) {
                  NavBarCubit.get(context).changeIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetsData.home,
                      width: 20.w,
                      height: 20.h,
                      color: NavBarCubit.get(context).selectedIndex == 0
                          ? ColorsManager.kPrimaryColor
                          : ColorsManager.grey,
                    ),
                    label: S.of(context).Home,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetsData.category,
                      width: 20.w,
                      height: 20.h,
                      color: NavBarCubit.get(context).selectedIndex == 1
                          ? ColorsManager.kPrimaryColor
                          : ColorsManager.grey,
                    ),
                    label: S.of(context).Categories,
                  ),
                  BottomNavigationBarItem(
                    icon: BlocBuilder<CartCubit, CartState>(
                      builder: (context, cartState) {
                        return CartCubit.get(context).cartItemList.isEmpty
                            ? SvgPicture.asset(
                                AssetsData.cart,
                                width: 20.w,
                                height: 20.h,
                                color:
                                    NavBarCubit.get(context).selectedIndex == 2
                                        ? ColorsManager.kPrimaryColor
                                        : ColorsManager.grey,
                              )
                            : Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SvgPicture.asset(
                                    AssetsData.cart,
                                    width: 20.w,
                                    height: 20.h,
                                    color: NavBarCubit.get(context)
                                                .selectedIndex ==
                                            2
                                        ? ColorsManager.kPrimaryColor
                                        : ColorsManager.grey,
                                  ),
                                  Positioned(
                                    right: -9.w,
                                    top: -8.h,
                                    child: CircleAvatar(
                                      radius: 9.w,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        CartCubit.get(context)
                                            .cartItemList
                                            .length
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                      },
                    ),
                    label: S.of(context).Cart,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AssetsData.profile,
                      width: 20.w,
                      height: 20.h,
                      color: NavBarCubit.get(context).selectedIndex == 3
                          ? ColorsManager.kPrimaryColor
                          : ColorsManager.grey,
                    ),
                    label: S.of(context).Profile,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
