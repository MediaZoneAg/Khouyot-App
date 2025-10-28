import 'package:flutter/material.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_with_item.dart';

class SignWithBody extends StatelessWidget {
  const SignWithBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SignWithItem(
          logoIcon: AssetsData.apple,
          onPressed: () {},
          
        ),
        horizontalSpace(30),
        SignWithItem(
          logoIcon: AssetsData.google,
          onPressed: () {},
         
        ),
        horizontalSpace(30),
        SignWithItem(
          logoIcon: AssetsData.facebook,
          onPressed: () {},
          
        ),
      ],
    );
  }
}
