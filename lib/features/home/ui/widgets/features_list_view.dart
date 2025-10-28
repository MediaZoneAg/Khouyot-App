// lib/features/home/ui/widgets/features_list_view.dart
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
                // ======= CATEGORIES STRIP (Like the screenshot) =======
                Skeletonizer(
                  enabled: categoryState is CategoryLoading,
                  child: categoryCubit.topLevelCategories.isNotEmpty
                      ? SizedBox(
                          height: 40.h,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.only(left: 8.w),
                                  children: [
                                    _CategoryChip(
                                      label: 'All',
                                      selected:
                                          homeCubit.currentCategory == 'All',
                                      onTap: () {
                                        homeCubit.changeCurrentCategory('All');
                                        homeCubit.fetchAllProducts();
                                      },
                                    ),
                                    ...categoryCubit.topLevelCategories.map(
                                      (category) {
                                        final slug = category.slug ?? '';
                                        return _CategoryChip(
                                          label: homeCubit
                                              .getEnglishDisplayName(category),
                                          selected:
                                              homeCubit.currentCategory == slug,
                                          onTap: () {
                                            homeCubit
                                                .changeCurrentCategory(slug);
                                            homeCubit
                                                .changeId(category.id ?? 0);
                                            homeCubit
                                                .fetchProductAtSpecificCategories(
                                              category.id ?? 0,
                                              slug,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),

                              // Thin divider
                              Container(
                                height: 40.h,
                                width: 1,
                                margin: EdgeInsets.symmetric(horizontal: 10.w),
                                color: const Color(0xFFE7E7E7),
                              ),

                              // Square menu button (filters/menu)
                              _SquareIconButton(
                                icon: BlocBuilder<ThemeCubit, ThemeState>(
                                  builder: (context, state) {
                                    final isLight =
                                        ThemeCubit.get(context).themeMode ==
                                            ThemeMode.light;
                                    return CustomSvg(
                                      imgPath: AssetsData.menu,
                                      color: isLight
                                          ? ColorsManager.darkGrey
                                          : ColorsManager.mainWhite,
                                    );
                                  },
                                ),
                                onTap: () =>
                                    NavBarCubit.get(context).changeIndex(1),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                verticalSpace(12),

                // ======= PRODUCTS GRID (switches between All vs Current) =======
                const Expanded(child: CategoryGridView()),
              ],
            );
          },
        );
      },
    );
  }
}

/// ===========================
/// Inline reusable widgets
/// ===========================

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 8.w),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.r),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: selected ? ColorsManager.kPrimaryColor : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: selected
                ? null
                : Border.all(color:  Color(0xFFF8F8F8), width: 1),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : const Color(0xFF333333),
                height: 1.1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  const _SquareIconButton({
    required this.icon,
    required this.onTap,
  });

  final Widget icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10.r),
      onTap: onTap,
      child: icon,
    );
  }
}
