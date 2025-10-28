// payment_option_tile.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';

class PaymentOptionTile extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;

  const PaymentOptionTile({
    super.key,
    required this.title,
    required this.value,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 370,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ColorsManager.grey),
      ),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return ListTile(
                title: Text(
                  title,
                  style: TextStyles.font16BlackRegular.copyWith(
                      color:
                          ThemeCubit.get(context).themeMode == ThemeMode.light
                              ? Colors.black
                              : ColorsManager.mainWhite),
                ),
                leading: CustomSvg(
                    imgPath: iconPath,
                    color: ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? Colors.black
                        : ColorsManager.mainWhite),
                trailing: Radio<String>(
                  value: value,
                  groupValue: CartCubit.get(context).selectedPaymentMethod,
                  onChanged: (selectedValue) {
                    CartCubit.get(context).selectPaymentMethod(selectedValue!);
                  },
                  activeColor: ColorsManager.kPrimaryColor,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
