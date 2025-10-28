import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/category_item.dart';
import 'package:khouyot/features/home/ui/widgets/pagination_loading.dart';
import 'package:khouyot/features/home/ui/widgets/ui_products_loading.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryGridViewCurrent extends StatefulWidget {
  const CategoryGridViewCurrent({super.key});

  @override
  State<CategoryGridViewCurrent> createState() => _CategoryGridViewCurrentState();
}

class _CategoryGridViewCurrentState extends State<CategoryGridViewCurrent> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FavCubit, FavState>(
        builder: (context, _) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final homeCubit = HomeCubit.get(context);
              final currentList = homeCubit.categoriesMap[homeCubit.currentCategory] ?? [];

              if (state is FetchProductAtSpecificCategoriesLoading) {
                return const Skeletonizer(enabled: true, child: UiLoadingProducts());
              }

              if (state is FetchProductAtSpecificCategoriesFailure) {
                return _ErrorRetry(
                  text: "Failed to load category products",
                  onRetry: () => homeCubit.fetchProductAtSpecificCategories(
                    homeCubit.currentId,
                    homeCubit.currentCategory,
                  ),
                );
              }

              if (currentList.isEmpty) {
                return _ErrorRetry(
                  text: "No products in this category",
                  onRetry: () => homeCubit.fetchProductAtSpecificCategories(
                    homeCubit.currentId,
                    homeCubit.currentCategory,
                  ),
                );
              }

              return GridView.builder(
                controller: homeCubit.scrollControllerCurrent,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0.w,
                  mainAxisExtent: 220.h,
                ),
                itemCount: currentList.length +
                    (state is MoreProductSpecificLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (state is MoreProductSpecificLoading &&
                      index == currentList.length) {
                    return const Skeletonizer(enabled: true, child: UiLoadingPagination());
                  }

                  final item = currentList[index];
                  return CategoryItem(
                    product: item,
                    isClicked: FavCubit.get(context).favorite.contains(item.id),
                    onTap1: () {
                      Navigator.pushNamed(context, Routes.categoryDetails, arguments: item);
                    },
                    onTap2: () async {
                      await _toggleFav(context, item);
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _toggleFav(BuildContext context, Data product) async {
    if (await CashHelper.getStringSecured(key: Keys.token) != "") {
      final favCubit = FavCubit.get(context);
      if (favCubit.favorite.contains(product.id)) {
        final favModel = product.variants?.first.convertToFav(
          productName: product.name,
          description: product.description,
        );
        if (favModel != null) {
          await favCubit.removeFromWishList(model: favModel);
          await favCubit.getWishList();
        }
      } else {
        await favCubit.addToWishList(model: ProductModel(data: [product]));
        await favCubit.getWishList();
      }
    } else {
      showSnackBar(
        context: NavigationService.navigatorKey.currentState!.context,
        text: S.of(context).YouNeedToLoginFirst,
      );
    }
  }
}
class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({
    required this.text,
    required this.onRetry,
  });

  final String text;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Optional: requires your lottie asset + import
        Lottie.asset(AssetsData.empty),
        Text(
          text,
          style: TextStyles.font16darkBlackRegular,
        ),
        verticalSpace(10),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text("Retry"),
        ),
      ],
    );
  }
}
