import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActionItem extends StatelessWidget {
  const ActionItem({super.key, required this.onTap, required this.iconContent});
  final VoidCallback onTap;
  final Icon iconContent;

  @override
  Widget build(BuildContext context) {
    return InkWell(
              onTap: onTap,
              child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.7),
                      shape: BoxShape.circle),
                  child: iconContent),
            );
  }
}