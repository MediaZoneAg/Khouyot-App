import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/models/parent_category_model.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/category/ui/widgets/child_category_item.dart';
import 'package:khouyot/features/category/ui/widgets/child_sub_category_item.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({super.key});

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        final categoriesList = CategoryCubit.get(context).categoriesMap[
                CategoryCubit.get(context).currentId.toString()] ??
            [
              ParentCategoryModel(products: [
      Products(
          id: 1,
          name: 'Dress',
          image:
              'https://i.pinimg.com/564x/3e/0e/3a/3e0e3a9b3e9c4b9c2b8c9c2b8c2b8c2b.jpg'),
      Products(
          id: 2,
          name: 'T-shirts',
          image:
              'https://i.pinimg.com/564x/3e/0e/3a/3e0e3a9b3e9c4b9c2b8c9c2b8c2b8c2b.jpg'),
      Products(
         id: 3,
          name: 'T-shirts',
          image:
              'https://i.pinimg.com/564x/3e/0e/3a/3e0e3a9b3e9c4b9c2b8c9c2b8c2b8c2b.jpg'),
              ])
             
            ];
        return categoriesList.isEmpty
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 100.h),
                child: Lottie.asset(AssetsData.empty),
              )
            : Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height: 75.h,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categoriesList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: ChildCategoriesItem(
                              parentCategoryModel: categoriesList[index],
                              isSelected: CategoryCubit.get(context)
                                      .currentContentIndex ==
                                  index,
                              onTap: () {
                                CategoryCubit.get(context)
                                    .changeCurrentContentIndex(index);
                              //   CategoryCubit.get(context)
                              //       .fetchChildSubCategories(
                              //           categoriesList[index].category!.id!, index);
                               },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      height:
                          CategoryCubit.get(context).currentContentIndex != null
                              ? categoriesList[CategoryCubit.get(context)
                                          .currentContentIndex!]
                                      .subCategories
                                      .length *
                                  150.h
                              : 30.h,
                      child: Skeletonizer(
                        enabled: state is ChildSubCategoryLoading,
                        child: CategoryCubit.get(context).currentContentIndex ==
                                null
                            ? Center(
                                child: Text(
                                  'Please select a the SubCategory',
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              )
                            : GridView(
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4.0,
                                  childAspectRatio: 0.5,
                                  mainAxisExtent: 275,
                                ),
                                children: [
                                    ...categoriesList[CategoryCubit.get(context)
                                            .currentContentIndex!]
                                        .subCategories
                                        .map((e) => ChildSubCategoriesItem(
                                              parentCategoryModel: categoriesList[
                                                      CategoryCubit.get(context)
                                                          .currentContentIndex!]
                                                  .subCategories[categoriesList[
                                                      CategoryCubit.get(context)
                                                          .currentContentIndex!]
                                                  .subCategories
                                                  .indexOf(e)],
                                              isSelected: CategoryCubit.get(
                                                          context)
                                                      .currentSubContentIndex ==
                                                  categoriesList[CategoryCubit
                                                              .get(context)
                                                          .currentContentIndex!]
                                                      .subCategories
                                                      .indexOf(e),
                                              onTap: () {
                                                CategoryCubit.get(context)
                                                    .changeSubContentIndex(
                                                        categoriesList[CategoryCubit
                                                                    .get(
                                                                        context)
                                                                .currentContentIndex!]
                                                            .subCategories
                                                            .indexOf(e),
                                                        true);
                                                CategoryCubit.get(context)
                                                    .fetchProductSubSubCategories(
                                                  categoriesList[CategoryCubit
                                                              .get(context)
                                                          .currentContentIndex!]
                                                      .subCategories[categoriesList[
                                                              CategoryCubit.get(
                                                                      context)
                                                                  .currentContentIndex!]
                                                          .subCategories
                                                          .indexOf(e)].category!
                                                      .id!,
                                                );
                                                context.pushNamed(
                                                    Routes.productScreen);
                                              },
                                            ))
                                  ]),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
