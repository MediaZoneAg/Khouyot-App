import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/di/Dependency_inj.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/screens/cart_screen.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/category/ui/screens/category_screen.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/screens/home_screen.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/profile/ui/screens/profile_screen.dart';
import 'package:meta/meta.dart';

part 'nav_bar_state.dart';

class NavBarCubit extends Cubit<NavBarState> {
  NavBarCubit() : super(NavBarInitial());
  static NavBarCubit get(context) => BlocProvider.of(context);
  PageController pageController = PageController();

  int selectedIndex = 0;
  final screens = [
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>.value(
          value: getIt<HomeCubit>(),
        ),
        BlocProvider<CategoryCubit>.value(
          value: getIt<CategoryCubit>(),
        ),
        BlocProvider<ProfileCubit>.value(
          value: getIt<ProfileCubit>(),
        ),
        BlocProvider<CartCubit>.value(
          value: getIt<CartCubit>(),
        ),
        BlocProvider<FavCubit>.value(
          value: getIt<FavCubit>(),
        ),
      ],
      child: const HomeScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<CategoryCubit>.value(
          value: getIt<CategoryCubit>(),
        ),
        BlocProvider<FavCubit>.value(
          value: getIt<FavCubit>(),
        ),
      ],
      child: const CategoryScreen(),
    ),
    BlocProvider<CartCubit>.value(
      value: getIt<CartCubit>(),
      child: const CartScreen(),
    ),
    MultiBlocProvider(
      providers: [
        BlocProvider<ProfileCubit>.value(
          value: getIt<ProfileCubit>(),
        ),
      ],
      child: const ProfileScreen(),
    ),
  ];
  void changeIndex(int newIndex, {bool jumping = true}) {
    selectedIndex = newIndex;
    if (jumping) {
      pageController.jumpToPage(newIndex); // Navigate to the specified page
    }
    emit(ChangeIndex());
  }
}
