import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/cart/data/models/cart_item_model.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';

class CartDetailsItem extends StatelessWidget {
  const CartDetailsItem({super.key,required this.cartItemModel,required this.increase, required this.decrease, required this.text});
  final CartItemModel cartItemModel;
  final VoidCallback increase;
  final VoidCallback decrease;
  final String text;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  return SizedBox(
                    height: 130.h,
                    child: Row(
                      children: [
                        AppCachedNetworkImage(image: cartItemModel.productModel.data?.first.variants?.first.image![0], width: 125.w, height: 170.h, radius: 10,),
                        horizontalSpace(20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                cartItemModel.productModel.data?.first.name ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyles.font18BlackMedium.copyWith(
                                  color: ColorsManager.kPrimaryColor,
                                ),
                              ),
                              Text(
                                "Price: ${cartItemModel.productModel.data?.first.variants?.first.price} EGP",
                                style: TextStyles.font14KprimaryRegular,
                              ),
                              Text( "Quantity: $text", style: TextStyles.font14KprimaryRegular,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
  }
}