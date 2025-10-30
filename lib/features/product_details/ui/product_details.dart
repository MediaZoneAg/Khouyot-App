import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/product_details/ui/widget/add_to_cart_button.dart';
import 'package:khouyot/features/product_details/ui/widget/button_sheet.dart';
import 'package:khouyot/features/product_details/ui/widget/category_details_imgs.dart';
import 'package:khouyot/features/product_details/ui/widget/select_color_item.dart';
import 'package:khouyot/features/product_details/ui/widget/select_size_item.dart';

import '../../../generated/l10n.dart';
import '../../cart/logic/cart_cubit.dart';
import '../logic/product_details_cubit.dart';
class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productModel});
  final Data productModel;

  @override
  State<ProductDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<ProductDetails> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //ProductDetailsCubit.get(context).getProductDetails(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit,ProductDetailsState>(

  builder: (context, state) {
    if(state is ProductDetailsLoading){
      return Center(child: CircularProgressIndicator(color: ColorsManager.kPrimaryColor,),);
    }
    else {
     // final widget=ProductDetailsCubit.get(context);
          return BlocBuilder<ProductDetailsCubit,ProductDetailsState>(
  builder: (context, state) {
    return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Scaffold(
                backgroundColor:
                    ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.mainWhite
                        : ColorsManager.kSecondaryColor,
                bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
                  builder: (context, state) {
                    return AddToCartPriceButton(
                      text: S.of(context).AddToCart,
                      price: CartCubit.get(context).total,
                      onTap: () async {
                        await showAddToCartBottomSheet(
                            context, widget.productModel);
                      },
                    );
                  },
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //AppCachedNetworkImage(image: widget.productModel.data.,),
                          CategoryDetailsImgs(
                              productModel: widget.productModel),
                          verticalSpace(10),
                          SizedBox(
                            height: 44.h,
                            width: 330.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${widget.productModel.name}",
                                  style: TextStyles.font20BlackMedium.copyWith(
                                    color: ThemeCubit.get(context).themeMode ==
                                            ThemeMode.light
                                        ? ColorsManager.black
                                        : ColorsManager.mainWhite,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: const CustomSvg(
                                        imgPath: AssetsData.export)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 131.w,
                            child: Row(
                              children: [
                                Text(
                                  '${widget.productModel.variants?.firstOrNull?.price} EGP',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorsManager.kPrimaryColor,
                                  ),
                                ),
                                // const Spacer(),
                                // Icon(Icons.star, color: Colors.yellow, size: 17.sp),
                                // Text(
                                //   '${widget.productModel.averageRating}',
                                //   style: TextStyle(
                                //     fontSize: 14.sp,
                                //     color: ThemeCubit.get(context).themeMode ==
                                //             ThemeMode.light
                                //         ? ColorsManager.darkBlack
                                //         : ColorsManager.mainWhite,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          verticalSpace(20),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            builder: (context, state) {
                              return SelectColorItem(
                                onTap: ProductDetailsCubit.get(context)
                                    .changeSelectedColor1,
                                selectedColor: ProductDetailsCubit.get(context)
                                    .selectedColor1,
                              );
                            },
                          ),
                          verticalSpace(20),
                          BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
                            builder: (context, state) {
                              return SelectSizeItem(
                                  onTap: ProductDetailsCubit.get(context)
                                      .changeSelectedSize1,
                                  selectedSize: ProductDetailsCubit.get(context)
                                      .selectedSize1);
                            },
                          ),
                          // verticalSpace(20),
                          // Text('Review (12)', style: TextStyles.font16BlackRegular),
                          // const ReviewItem(
                          //   personImage: AssetsData.cat2,
                          //   title: 'Tony Stark',
                          //   time: '1 Month ago',
                          //   text:
                          //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ',
                          // ),
                          // verticalSpace(10),
                          // const ReviewItem(
                          //   personImage: AssetsData.cat3,
                          //   title: 'Peter Parker',
                          //   time: '1 Month ago',
                          //   text:
                          //       'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et ',
                          // ),
                          // verticalSpace(10),
                          // AppTextButton(
                          //   buttonText: 'See All Reviews',
                          //   textStyle: TextStyles.font14KprimaryRegular,
                          //   onPressed: () {},
                          //   buttonWidth: 320,
                          //   backgroundColor: Colors.transparent,
                          //   //verticalPadding: 10,
                          // ),
                          // AppTextButton(
                          //   buttonText: 'Download Size guide',
                          //   textStyle: TextStyles.font14DarkGreyRegular,
                          //   onPressed: () {},
                          //   buttonWidth: 320,
                          //   backgroundColor: Colors.transparent,
                          //   //verticalPadding: 10,
                          //   borderColor: ColorsManager.grey,
                          // ),
                          // verticalSpace(20),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  },
);
        }
      },
);
  }
}