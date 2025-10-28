import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/favorite/ui/widgets/ui_wish_list_loading.dart';
import 'package:khouyot/features/favorite/ui/widgets/wish_list_item.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

class WishListGridView extends StatelessWidget {
  const WishListGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        if (state is GetWishListLoading) {
          return const Skeletonizer(
            enabled: true,
            child: UiLoadingWishList(),
          );
        }
        if (FavCubit.get(context).wishList.isNotEmpty) {
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14.0.w,
                childAspectRatio: 0.76,
                mainAxisExtent: 275.h,
              ),
              itemCount: FavCubit.get(context).wishList.length,
              itemBuilder: (context, index) => WishListItem(
                    isClicked: FavCubit.get(context)
                        .favorite
                        .contains(FavCubit.get(context).wishList[index].id),
                    wishListModel: FavCubit.get(context).wishList[index],
                    onTap1: () {
                      context.pushNamed(
                        Routes.categoryDetails,
                        arguments: FavCubit.get(context)
                            .wishList[index]
                            .toProductModel(),
                      );
                    },

                    onTap2: () {
                      FavCubit.get(context).removeFromWishList(
                          model: FavCubit.get(context).wishList[index]);
                    }, // Implement your onTap logic here
                  ));
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 140.h),
            child: Lottie.asset(AssetsData.empty),
          );
        }
      },
    );
  }
}
