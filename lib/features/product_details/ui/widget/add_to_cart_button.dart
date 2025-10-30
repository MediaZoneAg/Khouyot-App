import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/generated/l10n.dart';

class AddToCartPriceButton extends StatelessWidget {
  const AddToCartPriceButton(
      {super.key,
      required this.text,
      required this.price,
      required this.onTap});
  final String text;
  final double price;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
          color: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          width: 350.w,
          height: 90.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).TotalPrice,
                      style: TextStyles.font14DarkGreyRegular),
                  Text('${price} EGP', style: TextStyles.font20KprimaryMedium),
                ],
              ),
              AppTextButton(
                buttonText: text,
                textStyle: TextStyles.font14WhiteRegular,
                onPressed: () async {
                  await onTap();
                  //    await showAddToCartBottomSheet(context, productModel);
                },
                buttonWidth: 130.w,
                buttonHeight: 30.h,
                backgroundColor: ColorsManager.kPrimaryColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
