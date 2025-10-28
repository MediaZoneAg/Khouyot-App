import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class ProfileInfoItem extends StatelessWidget {
  const ProfileInfoItem({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsManager.grey)),
      child: Text(
        content,
        style: TextStyles.font16DarkgreyRegular,
      ),
    );
  }
}
