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
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';
import 'package:khouyot/features/home/ui/widgets/add_to_cart_button.dart';
import 'package:khouyot/features/home/ui/widgets/button_sheet.dart';
import 'package:khouyot/features/home/ui/widgets/category_details_imgs.dart';
import 'package:khouyot/features/home/ui/widgets/select_color_item.dart';
import 'package:khouyot/features/home/ui/widgets/select_size_item.dart';
import 'package:khouyot/generated/l10n.dart';

class CategoryDetails extends StatefulWidget {
  const CategoryDetails({super.key, required this.productModel});
  final ProductModel productModel;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return AddToCartPriceButton(
                text: S.of(context).AddToCart,
                price: CartCubit.get(context).total,
                onTap: () async {
                  await showAddToCartBottomSheet(context, widget.productModel);
                },
              );
            },
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoryDetailsImgs(productModel: widget.productModel),
                    verticalSpace(10),
                    SizedBox(
                      height: 44.h,
                      width: 330.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${widget.productModel.data?.first.name}",
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
                              child:
                                  const CustomSvg(imgPath: AssetsData.export)),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 131.w,
                      child: Row(
                        children: [
                          Text(
                            '${widget.productModel.data!.first.variants?.first.price} EGP',
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
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return SelectColorItem(
                          onTap: HomeCubit.get(context).changeSelectedColor1,
                          selectedColor: HomeCubit.get(context).selectedColor1,
                        );
                      },
                    ),
                    verticalSpace(20),
                    BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        return SelectSizeItem(
                            onTap: HomeCubit.get(context).changeSelectedSize1,
                            selectedSize: HomeCubit.get(context).selectedSize1);
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
  }
}
