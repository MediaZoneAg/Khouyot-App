
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';

class SizeColor extends StatelessWidget {
  const SizeColor({super.key});

  @override
  Widget build(BuildContext context) {
// Fetch the selected item or fallback

    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          width: 125.w,
          height: 44.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorsManager.grey),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${CartCubit.get(context).selectedItem?.size ??
                CartCubit.get(context).cartList[0].size}/${CartCubit.get(context).selectedItem?.color ??
                CartCubit.get(context).cartList[0].color}', // Dynamically display selected item’s size and color
                style: TextStyles.font14BlackRegular,
              ),
              horizontalSpace(7),
              InkWell(
                onTap: () {
                  // Handle tap if needed
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 15.sp,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
