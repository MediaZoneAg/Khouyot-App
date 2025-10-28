import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/category_grid_view.dart';
import 'package:khouyot/features/home/ui/widgets/feature_item.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class FeaturesListView extends StatefulWidget {
  const FeaturesListView({super.key});

  @override
  State<FeaturesListView> createState() => _FeaturesListViewState();
}

class _FeaturesListViewState extends State<FeaturesListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        return BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, categoryState) {
            final categoryCubit = context.read<CategoryCubit>();
            final homeCubit = context.read<HomeCubit>();

            return Column(
              children: [
                Skeletonizer(
                  enabled: categoryState is CategoryLoading,
                  child: categoryCubit.topLevelCategories.isNotEmpty
                      ? SizedBox(
                          height: 60.h,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              // All button
                              FeatureItem(
                                name: "All",
                                isSelected: homeCubit.currentCategory == "All",
                                onTap: () {
                                  homeCubit.changeCurrentCategory("All");
                                  homeCubit.fetchAllProducts();
                                },
                              ),
                              ...categoryCubit.topLevelCategories
                                  .map((category) => FeatureItem(
                                        name: homeCubit.getEnglishDisplayName(category),
                                        isSelected: homeCubit.currentCategory ==
                                            category.slug,
                                        onTap: () {
                                          homeCubit.changeCurrentCategory(
                                              category.slug ?? "");
                                          homeCubit.changeId(category.id ?? 0);
                                          homeCubit
                                              .fetchProductAtSpecificCategories(
                                            category.id ?? 0,
                                            category.slug ?? "",
                                          );
                                        },
                                      )),
                              Container(
                                height: 50.h,
                                width: 0.5.w,
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  color: ThemeCubit.get(context).themeMode ==
                                          ThemeMode.light
                                      ? ColorsManager.offWhite
                                      : ColorsManager.darkGrey,
                                ),
                              ),

                              BlocBuilder<ThemeCubit, ThemeState>(
                                builder: (context, state) {
                                  return InkWell(
                                    onTap: () {
                                      NavBarCubit.get(context).changeIndex(1);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.w),
                                      child: CustomSvg(
                                        imgPath: AssetsData.menu,
                                        color:
                                            ThemeCubit.get(context).themeMode ==
                                                    ThemeMode.light
                                                ? ColorsManager.darkGrey
                                                : ColorsManager.mainWhite,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
                verticalSpace(12),
                // Products grid view
                const CategoryGridView(),
              ],
            );
          },
        );
      },
    );
  }
}