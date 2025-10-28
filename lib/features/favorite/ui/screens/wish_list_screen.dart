import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/favorite/ui/widgets/wish_list_grid_view.dart';
import 'package:khouyot/generated/l10n.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    FavCubit.get(context).getWishList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                FavCubit.get(context).getWishList();
              },
              child: Column(
                children: [
                  CustomAppBar(
                    barIcon: Icons.arrow_back_ios,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: S.of(context).WishList,
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(
                      right: 20.w,
                      left: 20.w,
                    ),
                    child: const WishListGridView(),
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
