import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/category/logic/category_cubit.dart';
import 'package:khouyot/features/category/ui/widgets/loading_ui_category_products.dart';
import 'package:khouyot/features/category/ui/widgets/sub_category_item.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/pagination_loading.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SubCategoryGridView extends StatefulWidget {
  const SubCategoryGridView({super.key});

  @override
  State<SubCategoryGridView> createState() => _SubCategoryGridViewState();
}

class _SubCategoryGridViewState extends State<SubCategoryGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, favState) {
        return BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, categoryState) {
            if (categoryState is FetchProductSubSubCategoriesLoading) {
              return const Skeletonizer(
                enabled: true,
                child: UiLoadingCategoryProducts(),
              );
            }
            return CategoryCubit.get(context)
                    .productSubSubCategoriesList
                    .isEmpty
                ? Lottie.asset(AssetsData.empty)
                : SizedBox(
                    height: CategoryCubit.get(context)
                            .productSubSubCategoriesList
                            .length *
                        160.h,
                    child: GridView(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0.w,
                        childAspectRatio: 0.76,
                        mainAxisExtent: 270.h,
                      ),
                      children: [
                        ...CategoryCubit.get(context)
                            .productSubSubCategoriesList
                            .map((e) => SubCategoryItem(
                                  productModel: e,
                                  onTap1: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.categoryDetails,
                                      arguments: e,
                                    );
                                  },
                                  isClicked: FavCubit.get(context)
                                      .favorite
                                      .contains(e.data?.first.id),
                                  onTap2: () async {
                                    await favFunction(
                                        CategoryCubit.get(context)
                                            .productSubSubCategoriesList
                                            .indexOf(e),
                                        e.data!.first.id!);
                                  },
                                )),
                        BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            if (state is ProductAllLoadingMore) {
                              return const Skeletonizer(
                                enabled: true,
                                child: UiLoadingPagination(),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            if (state is ProductAllLoadingMore) {
                              return const Skeletonizer(
                                enabled: true,
                                child: UiLoadingPagination(),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          },
                        )
                      ],
                    ),
                  );
          },
        );
      },
    );
  }

  Future<void> favFunction(int index, int productId) async {
    final favCubit = FavCubit.get(context);
    if (await CashHelper.getStringSecured(key: Keys.token) != "") {
      if (favCubit.favorite.contains(productId)) {
        favCubit.removeFromWishList(
          model: CategoryCubit.get(context)
              .productSubSubCategoriesList[index]
              .convertToFav(), // ✅ correct spelling
        );
      } else {
        favCubit
            .addToWishList(
                model: CategoryCubit.get(context)
                    .productSubSubCategoriesList[index])
            .then((value) => favCubit.getWishList());
      }
    } else {
      showSnackBar(
        context: NavigationService.navigatorKey.currentState!.context,
        text: S.of(context).YouNeedToLoginFirst,
      );
    }
  }
}
