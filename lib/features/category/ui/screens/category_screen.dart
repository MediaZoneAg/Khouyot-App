import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/widgets/app_category_app_bar.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/category/ui/widgets/parent_category.dart';
import 'package:khouyot/generated/l10n.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    CategoryCubit.get(context).fetchCategories();
    CategoryCubit.get(context).fetchChildSubCategories(
    CategoryCubit.get(context).categories[0].data!.first.id!, 0);
    CategoryCubit.get(context).fetchProductSubSubCategories(
    CategoryCubit.get(context).categories[0].data!.first.id!,
    );
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
            child: Padding(
              padding: EdgeInsets.only(right: 15.w, left: 15.w, top: 20.h),
              child: RefreshIndicator(
                onRefresh: () async {
                  await CategoryCubit.get(context)
                      .fetchCategories(getOnlyFormNetwork: true);
                  await CategoryCubit.get(context).fetchProductSubSubCategories(
                      CategoryCubit.get(context)
                          .categoriesMap[
                              CategoryCubit.get(context).currentId.toString()]![
                              CategoryCubit.get(context).currentContentIndex!]
                          .subCategories[CategoryCubit.get(context)
                              .currentSubContentIndex!].category!
                          .id!,
                      getOnlyFormNetwork: true);
                },
                child: ListView(
                  //controller: CategoryCubit.get(context).scrollController,
                  children: [
                    CategoryAppBar(
                      title: S.of(context).Categories,
                      onTap2: () {
                        context.pushNamed(Routes.searchScreen);
                      },
                      onTap1: () async {
                        if (await CashHelper.getStringSecured(
                                key: Keys.token) !=
                            "") {
                          context.pushNamed(Routes.notificationScreen);
                        } else {
                          showSnackBar(
                              context: NavigationService
                                  .navigatorKey.currentState!.context,
                              text: S.of(context).Youneedtologinfirst);
                        }
                      },
                      onTap3: () async {
                        if (await CashHelper.getStringSecured(
                                key: Keys.token) !=
                            "") {
                          context.pushNamed(Routes.wishListScreen);
                        } else {
                          showSnackBar(
                              context: NavigationService
                                  .navigatorKey.currentState!.context,
                              text: S.of(context).Youneedtologinfirst);
                        }
                      },
                    ),
                    verticalSpace(40),
                    const ParentCategory(),
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
