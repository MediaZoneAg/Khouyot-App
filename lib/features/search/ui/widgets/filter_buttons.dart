import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap1,
    required this.onTap2,
  });
  final String text1;
  final String text2;
  final Function() onTap1;
  final Function() onTap2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w,
        vertical: 46.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppTextButton(
            buttonText: text1,
            textStyle: TextStyles.font18WhiteMedium,
            onPressed: () async {
              await onTap1();
            },
            buttonWidth: 156,
            buttonHeight: 44,
            borderRadius: 10.r,
            backgroundColor: ColorsManager.kPrimaryColor,
            //verticalPadding: 10,
          ),
          AppTextButton(
            buttonText: text2,
            textStyle: TextStyles.font18WhiteMedium,
            onPressed: () async {
              await onTap2();
            },
            buttonWidth: 156,
            buttonHeight: 44,
            borderRadius: 10.r,
            backgroundColor: ColorsManager.darkGrey,
          ),
        ],
      ),
    );
  }
}
