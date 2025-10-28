import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/action_button.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';

class IncreaseDecrease extends StatelessWidget {
  const IncreaseDecrease(
      {super.key,
      required this.text,
      required this.increase,
      required this.decrease});
  final String text;
  final VoidCallback increase;
  final VoidCallback decrease;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ActionButton(onTap: decrease, iconContent: Icons.remove),
              horizontalSpace(12),
              Text(text,
                  style: TextStyles.font18BlackMedium.copyWith(
                    color: ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.darkBlack
                        : ColorsManager.mainWhite,
                  )),
              horizontalSpace(12),
              ActionButton(onTap: increase, iconContent: Icons.add),
            ]);
          },
        );
      },
    );
  }
}
