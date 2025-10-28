import 'package:flutter/material.dart';
import 'package:khouyot/core/theming/styles.dart';

class PaymentItemInfo extends StatelessWidget {
  const PaymentItemInfo({super.key, required this.title, required this.value});
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.font18BlackRegular,
        ),
        Text(
          value,
          style: TextStyles.font18BlackRegular,
        )
      ],
    );
  }
}
