import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/models/product_model.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/image_network.dart';

class SubCategoryItem extends StatelessWidget {
  const SubCategoryItem(
      {super.key,
      required this.isClicked,
      required this.onTap1,
      required this.onTap2,
      required this.productModel});
  final bool isClicked;
  final VoidCallback onTap1;
  final VoidCallback onTap2;
  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
          ? ColorsManager.mainWhite
          : ColorsManager.kSecondaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
        child: Stack(children: [
          GestureDetector(
            onTap: onTap1,
            child: SizedBox(
              width: 160.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (productModel.data!.first.variants!.first.image!.isNotEmpty)
                    AppCachedNetworkImage(
                      image: productModel.data!.first.variants!.first.image![0],
                      width: 165.w,
                      height: 185.h,
                      radius: 10,
                    ),
                  verticalSpace(5),
                  Text(
                    productModel.data?.first.name ?? "Green Tall Coat",
                    style: TextStyles.font16Black,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(7),
                  Text(
                    "EGP ${productModel.data?.first.variants?.first.price ?? "25 EGP"}",
                    style: TextStyles.font16KprimaryRegular,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 10.h,
              left: 105.w,
              child: GestureDetector(
                onTap: onTap2,
                child: Container(
                    width: 37.w,
                    height: 37.h,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.7),
                        shape: BoxShape.circle),
                    child: isClicked
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20.sp,
                          )
                        : Icon(
                            Icons.favorite_border_outlined,
                            color: ColorsManager.darkGrey,
                            size: 20.sp,
                          )),
              ))
        ]),
      ),
    );
  }
}
