import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/widgets/error_container.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/search/logic/search_cubit.dart';
import 'package:khouyot/features/search/ui/widgets/category_filter_item.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Category extends StatelessWidget {
  const Category({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            return CategoryCubit.get(context).categories.isEmpty
                ? ErrorContainer(
                    title: S.of(context).failedtoloaddatarefreshthepage,
                  )
                : Skeletonizer(
                    enabled: state is CategoryLoading,
                    child: Wrap(
                      spacing: 30.0.w, // Horizontal space between items
                      runSpacing: 20.0, // Vertical space between rows
                      children:
                          CategoryCubit.get(context).categories.map((entry) {
                        return CategoryFilterItem(
                            parentCategoryModel: entry,
                            isSelected: entry.data?.first.id.toString() ==
                                SearchCubit.get(context).currentCategoryId,
                            onTap: () {
                              SearchCubit.get(context)
                                  .changeCategoryId(entry.data!.first.id.toString());
                            });
                      }).toList(),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
