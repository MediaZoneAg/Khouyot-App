import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/image_network.dart';

class OrdersItem extends StatelessWidget {
  const OrdersItem(
      {super.key,
      required this.image,
      required this.name,
      required this.price,
      required this.rate});
  final String image;
  final String name;
  final String price;
  final String rate;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: SizedBox(
          height: 100.h,
          child: Row(
            children: [
              AppCachedNetworkImage(
                image: image,
                width: 100.w,
                height: 100.h,
              ),
              horizontalSpace(20.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.font18BlackMedium.copyWith(
                            color: ColorsManager.kPrimaryColor,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'x1ggggg',
                          style: TextStyles.font14KprimaryRegular,
                        ),
                      ],
                    ),
                    Text(
                      price,
                      style: TextStyles.font14KprimaryRegular,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        //horizontalSpace(5.w),
                        Text(
                          rate,
                          style: TextStyles.font14KprimaryRegular,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
