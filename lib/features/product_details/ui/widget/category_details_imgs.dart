import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/features/product_details/data/model/prodec_details_model.dart';
import 'package:khouyot/features/product_details/logic/product_details_cubit.dart';
import 'package:khouyot/khouyot.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/functions/snak_bar.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/favorite/logic/cubit/fav_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/action_item.dart';
import 'package:khouyot/features/home/ui/widgets/total_image_screen.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryDetailsImgs extends StatefulWidget {
  const CategoryDetailsImgs({
    super.key,
    required this.productModel,
  });
  final Data productModel;

  @override
  _CategoryDetailsImgsState createState() => _CategoryDetailsImgsState();
}

class _CategoryDetailsImgsState extends State<CategoryDetailsImgs> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        verticalSpace(10),
        SizedBox(
          width: 350.w,
          height: 280.h,
          child: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount:
                    widget.productModel.variants?.firstOrNull?.image?.length ?? 0,
                onPageChanged: (index) {
                  ProductDetailsCubit.get(context).changeImageIndex(index);
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //HomeCubit.get(context).changeImageIndex(index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TotalImageScreen(
                                  image: widget.productModel.variants!.first
                                          .image?[index] ??
                                      '')));
                    },
                    child: Hero(
                      tag:
                          widget.productModel.variants!.first.image?[index] ??
                              '',
                      child: AppCachedNetworkImage(
                          image: widget.productModel.variants!.first
                                  .image?[index] ??
                              '',
                          width: 350.w,
                          height: 350.h,
                          radius: 10.r),
                    ),
                  );
                },
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: ActionItem(
                    onTap: () {
                      context.pop();
                    },
                    iconContent: Icon(
                      Icons.arrow_back,
                      color: ColorsManager.darkGrey,
                      size: 15.sp,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10.h,
                left: 220.w,
                child: BlocBuilder<FavCubit, FavState>(
                  builder: (context, state) {
                    return BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return CartCubit.get(context).cartItemList.isEmpty
                            ? Row(
                                children: [
                                  ActionItem(
                                    onTap: () {
                                      NavBarCubit.get(context).changeIndex(2);
                                      context.pop();
                                    },
                                    iconContent: Icon(
                                      Icons.shopping_cart_outlined,
                                      color: ColorsManager.darkGrey,
                                      size: 20.sp,
                                    ),
                                  ),
                                  horizontalSpace(5.w),
                                  GestureDetector(
                                    onTap: ()  {
                                       FavCubit.get(context).addToWishList(model: ProductModel(data:[ widget.productModel]));
                                       FavCubit.get(context).getWishList();
                                      ///await favFunction();
                                    },
                                    child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(.7),
                                            shape: BoxShape.circle),
                                        child: FavCubit.get(context)
                                                .wishList
                                                .any((e)=>e.id==
                                                    widget.productModel.id)
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 20.sp,
                                              )
                                            : Icon(
                                                Icons
                                                    .favorite_border_outlined,
                                                color: ColorsManager.darkGrey,
                                                size: 20.sp,
                                              )),
                                  )
                                ],
                              )
                            : Row(
                                children: [
                                  Stack(
                                    children: [
                                      ActionItem(
                                        onTap: () {
                                          NavBarCubit.get(context)
                                              .changeIndex(2);
                                          context.pop();
                                        },
                                        iconContent: Icon(
                                          Icons.shopping_cart_outlined,
                                          color: ColorsManager.darkGrey,
                                          size: 25.sp,
                                        ),
                                      ),
                                      Positioned(
                                        right: 1.w,
                                        top: 1.h,
                                        child: CircleAvatar(
                                          radius: 9.w,
                                          backgroundColor: Colors.red,
                                          child: Text(
                                            CartCubit.get(context)
                                                .cartItemList
                                                .length
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  horizontalSpace(5),
                                  GestureDetector(
                                    onTap: () async {
                                      //await favFunction();
                                    },
                                    child: Container(
                                        width: 40.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(.7),
                                            shape: BoxShape.circle),
                                        child: FavCubit.get(context)
                                                .favorite
                                                .contains(
                                                    widget.productModel.id)
                                            ? Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                                size: 20.sp,
                                              )
                                            : Icon(
                                                Icons
                                                    .favorite_border_outlined,
                                                color: ColorsManager.darkGrey,
                                                size: 20.sp,
                                              )),
                                  )
                                ],
                              );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        verticalSpace(10),
        SizedBox(
          height: 80.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.productModel.variants?.firstOrNull?.image?.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  ProductDetailsCubit.get(context).changeImageIndex(index);
                  _pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                  width: 68.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ProductDetailsCubit.get(context)
                                  .currentImageIndex ==
                              index
                          ? ColorsManager.kPrimaryColor
                          : Colors.transparent,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppCachedNetworkImage(
                    width: 68.w,
                    height: 70.h,
                    image:
                        widget.productModel.variants!.firstOrNull?.image?[index] ??
                            '',
                    radius: 8,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Future<void> favFunction() async {
  //   if (await CashHelper.getStringSecured(key: Keys.token) != "") {
  //     if (FavCubit.get(context)
  //         .favorite
  //         .contains(widget.productModel.data?.id)) {
  //       final favModel =
  //           widget.productModel.data?.variants.first.convertToFav(
  //         productName: widget.productModel.data?.name,
  //         description: widget.productModel.data?.description,
  //       );
  //
  //       if (favModel != null) {
  //         FavCubit.get(context)
  //             .removeFromWishList(model: favModel)
  //             .then((value) => FavCubit.get(context).getWishList());
  //       }
  //     } else {
  //       FavCubit.get(context)
  //           .addToWishList(
  //             model: widget.productModel,
  //           )
  //           .then((value) => FavCubit.get(context).getWishList());
  //     }
  //   } else {
  //     showSnackBar(
  //         context: NavigationService.navigatorKey.currentState!.context,
  //         text: S.of(context).YouNeedToLoginFirst);
  //   }
  // }
}
