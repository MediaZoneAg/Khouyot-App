// lib/features/category/ui/widgets/category_body.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/models/parent_category_model.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';

import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  /// avoid spamming fetch while building the grid
  final Set<int> _requestedCategoryIds = <int>{};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final cubit = CategoryCubit.get(context);

        // children list for the currently selected parent (by id)
        final categoriesList =
            cubit.categoriesMap[cubit.currentId.toString()] ??
                <ParentCategoryModel>[];

        if (categoriesList.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 100.h),
            child: Lottie.asset(AssetsData.empty),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- Top row: direct children of the selected parent ----------------
            SizedBox(
              height: 75.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  final item = categoriesList[index];
                  final selected = cubit.currentContentIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: GestureDetector(
                      onTap: () => cubit.changeCurrentContentIndex(index),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
                        padding: EdgeInsets.symmetric(horizontal: 15.w),
                        height: 44,
                        decoration: BoxDecoration(
                          color: selected
                              ? ColorsManager.kPrimaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: selected
                                ? Colors.transparent
                                : ColorsManager.grey,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          item.category?.name ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selected ? Colors.white : ColorsManager.darkGrey,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // ---------------- Sub-categories grid: each card shows its options immediately ----------------
            if (cubit.currentContentIndex == null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Center(
                  child: Text('Please select a Subcategory', style: TextStyle(fontSize: 16.sp)),
                ),
              )
            else
              GridView.builder(
                padding: EdgeInsets.only(top: 8.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    categoriesList[cubit.currentContentIndex!].subCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 6.0,
                  mainAxisExtent: 280,
                ),
                itemBuilder: (context, i) {
                  final sub = categoriesList[cubit.currentContentIndex!]
                      .subCategories[i];
                  final leafId = sub.category?.id;

                  // lazy load the products/options for this leaf category
                  if (leafId != null &&
                      !cubit.categoryOptionsMap.containsKey(leafId) &&
                      !_requestedCategoryIds.contains(leafId)) {
                    _requestedCategoryIds.add(leafId);
                    cubit.fetchProductSubSubCategories(leafId);
                  }

                  final isLoading = state is FetchProductSubSubCategoriesLoading &&
                      (leafId != null &&
                          (cubit.categoryProductsMap[leafId]?.isEmpty ?? true));

                  final options = (leafId != null)
                      ? (cubit.categoryOptionsMap[leafId] ?? const {})
                      : const <String, List<String>>{};

                  return _SubCategoryCard(
                    title: sub.category?.name ?? '',
                    isSelected: cubit.currentSubContentIndex == i,
                    onTap: () => cubit.changeSubContentIndex(i, true),
                    isLoading: isLoading,
                    options: options,
                  );
                },
              ),

            verticalSpace(8),
          ],
        );
      },
    );
  }
}

/// Card that renders the subcategory title + its options (from aggregated products)
class _SubCategoryCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLoading;
  final Map<String, List<String>> options;

  const _SubCategoryCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.isLoading,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(6.w),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? ColorsManager.kPrimaryColor : const Color(0xFFECECEC),
            width: isSelected ? 1.3 : 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: isLoading
            ? const Skeletonizer(enabled: true, child: _OptionsSkeleton())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14.sp,
                      color: ColorsManager.darkGrey,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  if (options.isEmpty)
                    Text(
                      'No options',
                      style: TextStyle(fontSize: 12.sp, color: ColorsManager.darkGrey),
                    )
                  else
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: options.entries.map((e) {
                            final name = e.key.trim();
                            final values = e.value;
                            final looksLikeColor = _looksLikeColorOption(name);
                            return Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorsManager.kPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  Wrap(
                                    spacing: 6.w,
                                    runSpacing: 6.w,
                                    children: values.map((v) {
                                      return looksLikeColor
                                          ? _ColorDot(label: v)
                                          : _Chip(text: v);
                                    }).toList(),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

/// Simple text chip
class _Chip extends StatelessWidget {
  final String text;
  const _Chip({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11.sp, color: ColorsManager.darkGrey),
      ),
    );
  }
}

/// Color chip (detects Arabic color names)
class _ColorDot extends StatelessWidget {
  final String label;
  const _ColorDot({required this.label});

  @override
  Widget build(BuildContext context) {
    final Color c = _colorFromName(label);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: c,
            border: Border.all(color: const Color(0x33000000)),
          ),
        ),
        SizedBox(height: 4.h),
        Text(label, style: TextStyle(fontSize: 10.sp, color: ColorsManager.darkGrey)),
      ],
    );
  }
}

class _OptionsSkeleton extends StatelessWidget {
  const _OptionsSkeleton();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            children: [
              Container(width: 60.w, height: 12.h, color: Colors.white),
              SizedBox(width: 10.w),
              Expanded(child: Container(height: 22.h, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

/// heuristics: treat option names that look like "color" as color swatches
bool _looksLikeColorOption(String name) {
  final n = name.toLowerCase().trim();
  return n.contains('لون') || n.contains('color') || n.contains('اللون');
}

/// very small mapper for common Arabic color names
Color _colorFromName(String name) {
  final n = name.toLowerCase().replaceAll(' ', '');
  if (n.contains('أحمر') || n.contains('احمر')) return Colors.red;
  if (n.contains('أبيض') || n.contains('ابيض')) return Colors.white;
  if (n.contains('أسود') || n.contains('اسود')) return Colors.black;
  if (n.contains('بيج')) return const Color(0xFFF5E6C8);
  if (n.contains('أزرق') || n.contains('ازرق')) return Colors.blue;
  if (n.contains('أخضر') || n.contains('اخضر')) return Colors.green;
  if (n.contains('رمادي')) return Colors.grey;
  if (n.contains('وردي')) return Colors.pink;
  if (n.contains('أصفر') || n.contains('اصفر')) return Colors.yellow;
  if (n.contains('بنفسجي')) return Colors.purple;
  if (n.contains('بني')) return const Color(0xFF6D4C41);
  if (n.contains('كحلي')) return const Color(0xFF001F3F);
  return const Color(0xFFE0E0E0);
}
