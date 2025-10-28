import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/features/cart/data/models/cart_model.dart';

class CartListViewItem extends StatelessWidget {
  final CartModel cartModel;
  final VoidCallback onTap;

  const CartListViewItem ({
    super.key,
    required this.cartModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onTap,
          child: SizedBox(
            width: 160.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align children to start
              children: [
                if(cartModel.imageUrl.isNotEmpty)
                Container(
                      height: 170.h,
                      width: 125.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(8),
                          image:  DecorationImage(
                              fit: BoxFit.fill,
                              image:
                                  AssetImage(cartModel.imageUrl))),
                    ),
                verticalSpace(5),
                Text(
                  cartModel.name,
                  style: TextStyles.font16KprimaryRegular,
                ),
                verticalSpace(7),
                Text(
                  " EGP ${cartModel.price}",
                  style: TextStyles.font16KprimaryRegular,
                ),
              ],
            ),
          ),
        );
  }
}

