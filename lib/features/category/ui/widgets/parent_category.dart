import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/error_container.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/category/ui/widgets/Category_body.dart';
import 'package:khouyot/features/category/ui/widgets/categories_item.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ParentCategory extends StatelessWidget {
  const ParentCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 60.h,
          child: BlocBuilder<CategoryCubit, CategoryState>(
            builder: (context, state) {
              return CategoryCubit.get(context).categories.isEmpty
                  ? ErrorContainer(
                      title: S.of(context).failedtoloaddatarefreshthepage,
                    )
                  : Skeletonizer(
                      enabled: state is CategoryLoading,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: CategoryCubit.get(context).categories.length,
                        itemBuilder: (context, index) {
                          return CategoriesItem(
                            parentCategoryModel:
                                CategoryCubit.get(context).categories[index],
                            isSelected:
                                CategoryCubit.get(context).currentPageIndex ==
                                    index,
                            onTap: () {
                              CategoryCubit.get(context).changeCurrentIndex(
                                  index,
                                  CategoryCubit.get(context)
                                          .categories[index].data!.first
                                        .id ??
                                      1);
                              CategoryCubit.get(context).fetchChildCategories(
                                  CategoryCubit.get(context)
                                          .categories[index].data!.first
                                        .slug ??
                                      "");
                              CategoryCubit.get(context).currentContentIndex =
                                  null;
                            },
                          );
                        },
                      ),
                    );
            },
          ),
        ),
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            return Skeletonizer(
              enabled: state is CategoryLoading ||
                  state is ChildCategoryLoading, // Show skeleton during loading
              child: CategoryCubit.get(context).categories.isEmpty
                  ? Lottie.asset(
                      AssetsData.offLine,
                    ) // Show error if any
                  : const CategoryBody(), // Display child categories content when data is loaded
            );
          },
        ),
      ],
    );
  }
}
