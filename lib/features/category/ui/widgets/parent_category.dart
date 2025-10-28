// lib/features/category/ui/widgets/parent_category.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/category/ui/widgets/category_body.dart';

/// Pretty-print a slug like "voluptas-mejyc" -> "Voluptas Mejyc"
String prettySlug(String? slug, {String fallback = ''}) {
  if (slug == null || slug.isEmpty) return fallback;
  return slug
      .replaceAll('_', '-') // normalize if underscores appear
      .split('-')
      .where((s) => s.trim().isNotEmpty)
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

class ParentCategory extends StatelessWidget {
  const ParentCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = CategoryCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------- TOP UNDERLINE TABS (NO "ALL") ----------
        SizedBox(
          height: 42.h,
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              final parents =
                  cubit.allCategories.where((c) => c.isTopLevel).toList();
              if (parents.isEmpty) return const SizedBox.shrink();

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(right: 8.w),
                separatorBuilder: (_, __) => SizedBox(width: 12.w),
                itemCount: parents.length,
                itemBuilder: (_, i) {
                  final p = parents[i];
                  final bool selected = cubit.currentPageIndex == i;

                  return InkWell(
                    onTap: () async {
                      // Make sure your cubit has: changeCurrentIndex(int, int, String)
                      cubit.changeCurrentIndex(i, p.id ?? 0, p.slug ?? "");
                      await cubit.fetchChildCategories(p.slug ?? "");
                      cubit.currentContentIndex = null; // reset sub selection
                      cubit.currentSubContentIndex = null;
                    },
                    child: Container(
                      padding:
                          EdgeInsets.only(bottom: 8.h, left: 20.h, right: 20.h),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: selected
                                ? ColorsManager.kPrimaryColor
                                : ColorsManager.grey,
                            width: selected ? 2 : 1,
                          ),
                        ),
                      ),
                      child: Text(
                        prettySlug(p.slug, fallback: p.name ?? ''),
                        style: selected
                            ? TextStyles.font16BlackRegular
                            : TextStyles.font16DarkgreyRegular,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        // ---------- SECOND ROW: SMALL ROUNDED CHIPS ----------
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            // use the currently selected parent's slug to read its children
            final parentKey = cubit.currentParentSlug;
            final children = (parentKey.isNotEmpty
                    ? cubit.categoriesMap[parentKey]
                    : null) ??
                const [];

            if (children.isEmpty) {
              // keep layout stable
              return SizedBox(height: 40.h);
            }

            return SizedBox(
              height: 40.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                separatorBuilder: (_, __) => SizedBox(width: 8.w),
                itemCount: children.length,
                itemBuilder: (_, i) {
                  final item = children[i];
                  final bool selected = cubit.currentContentIndex == i;

                  // prefer the category's slug; otherwise try first product's slug
                  final chipSlug =
                      item.category?.slug ?? item.products?.first.slug ?? '';
                  final chipFallback =
                      item.category?.name ?? item.products?.first.name ?? '';

                  return GestureDetector(
                    onTap: () {
                      cubit.changeCurrentContentIndex(i);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: selected
                            ? ColorsManager.kPrimaryColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: selected
                              ? ColorsManager.kPrimaryColor
                              : const Color(0xFFE8E8E8),
                        ),
                        boxShadow: selected
                            ? [
                                BoxShadow(
                                  color: ColorsManager.kPrimaryColor
                                      .withOpacity(.20),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                )
                              ]
                            : const [
                                BoxShadow(
                                  color: Color(0x11000000),
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                )
                              ],
                      ),
                      child: Text(
                        prettySlug(chipSlug, fallback: chipFallback),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              selected ? Colors.white : ColorsManager.darkGrey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
        // ---------- BODY: sub-cards + products ----------
        const CategoryBody(),
      ],
    );
  }
}
