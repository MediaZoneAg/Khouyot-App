import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/image_network.dart';
import 'package:khouyot/features/cart/data/models/cart_item_model.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/cart/ui/widgets/increase_decrease.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.cartItemModel,
      required this.onRemove,
      required this.increase,
      required this.decrease,
      required this.text});
  final CartItemModel cartItemModel;
  final VoidCallback onRemove;
  final VoidCallback increase;
  final VoidCallback decrease;
  final String text;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return SizedBox(
              height: 130.h,
              child: Row(
                children: [
                  AppCachedNetworkImage(
                    image: cartItemModel.productModel.data!.first.variants!.first.image![0],
                    width: 125.w,
                    height: 170.h,
                    radius: 10,
                  ),
                  horizontalSpace(20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cartItemModel.productModel.data!.first.name!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.font18BlackMedium.copyWith(
                            color: ColorsManager.black,
                          ),
                        ),
                        Text(
                          "${cartItemModel.productModel.data?.first.variants?.first.price} EGP",
                          style: TextStyles.font14KprimaryRegular,
                        ),
                        //const SizeColor(),
                        Row(
                          children: [
                            IncreaseDecrease(
                              text: text,
                              increase: increase,
                              decrease: decrease,
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: onRemove,
                              child: SvgPicture.asset(
                                AssetsData.delete,
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
