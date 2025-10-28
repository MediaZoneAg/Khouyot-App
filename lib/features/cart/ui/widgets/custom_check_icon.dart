import 'package:flutter/material.dart';
import 'package:khouyot/core/theming/colors.dart';

class CustomCheckIcon extends StatelessWidget {
  const CustomCheckIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 50,
      backgroundColor: Color(0xFFD9D9D9),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: ColorsManager.kPrimaryColor,
        child: Icon(
          Icons.check,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }
}
