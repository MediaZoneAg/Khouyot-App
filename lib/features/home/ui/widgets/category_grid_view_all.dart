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

class CategoryGridViewAll extends StatelessWidget {
  const CategoryGridViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<FavCubit, FavState>(
        builder: (context, _) {
          return BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final homeCubit = HomeCubit.get(context);

              if (state is ProductAllLoading) {
                return const Skeletonizer(enabled: true, child: UiLoadingProducts());
              }

              if (state is ProductAllFailure) {
                return _ErrorRetry(
                  text: "Failed to load products",
                  onRetry: () => homeCubit.fetchAllProducts(),
                );
              }

              if (homeCubit.allProducts.isEmpty) {
                return _ErrorRetry(
                  text: "No products available",
                  onRetry: () => homeCubit.fetchAllProducts(),
                );
              }

              return GridView.builder(
                controller: homeCubit.scrollControllerAll,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0.w,
                  mainAxisExtent: 220.h,
                ),
                itemCount: homeCubit.allProducts.length +
                    (state is ProductAllLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (state is ProductAllLoadingMore &&
                      index == homeCubit.allProducts.length) {
                    return const Skeletonizer(enabled: true, child: UiLoadingPagination());
                  }

                  final item = homeCubit.allProducts[index];
                  return CategoryItem(
                    product: item,
                    isClicked: FavCubit.get(context).wishList.any((e)=>e.id==item.id),
                    onTap1: () {
                      Navigator.pushNamed(context, Routes.categoryDetails, arguments: item);
                    },
                    onTap2: (){
                      print(" is fave ${FavCubit.get(context).wishList.contains(item)}");
                      final favCubit = FavCubit.get(context);

                      favCubit.addToWishList(model: ProductModel(data: [item]));
                      favCubit.getWishList();
                      // await _toggleFav(context, item);
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
      favCubit.getWishList();
       favCubit.addToWishList(model: ProductModel(data: [product]));

    } else {
      showSnackBar(
        context: NavigationService.navigatorKey.currentState!.context,
        text: S.of(context).YouNeedToLoginFirst,
      );
    }
  }
}

class _ErrorRetry extends StatelessWidget {
  const _ErrorRetry({required this.text, required this.onRetry});
  final String text;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(AssetsData.empty),
        Text(text, style: TextStyles.font16darkBlackRegular),
        verticalSpace(10),
        ElevatedButton(onPressed: onRetry, child: const Text("Retry")),
      ],
    );
  }
}
