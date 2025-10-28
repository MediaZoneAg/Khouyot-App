import 'package:flutter/material.dart';
import 'package:khouyot/core/theming/styles.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key, required this.title, required this.value});

  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.font24BlackBold
        ),
        const Spacer(),
        Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyles.font20BlackMedium.copyWith(
            fontWeight: FontWeight.w400,),
        )
      ],
    );
  }
}
