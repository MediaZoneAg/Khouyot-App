import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/features/cart/ui/widgets/custom_check_icon.dart';
import 'package:khouyot/features/cart/ui/widgets/custom_dashed_line.dart';
import 'package:khouyot/features/cart/ui/widgets/thank_you_card.dart';

class ThankYouViewBody extends StatelessWidget {
  const ThankYouViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 70.h, bottom: 10.h),
      child: SizedBox(
        // Ensure the Stack has constraints
        height: MediaQuery.sizeOf(context).height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const ThankYouCard(),
            Positioned(
              bottom: MediaQuery.sizeOf(context).height * .2 +14.h,
              left: 28.w,
              right: 28.w,
              child: const CustomDashedLine(),
            ),
            Positioned(
              left: -20,
              bottom: MediaQuery.sizeOf(context).height * .2,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            Positioned(
              right: -20,
              bottom: MediaQuery.sizeOf(context).height * .2,
              child: const CircleAvatar(
                backgroundColor: Colors.white,
              ),
            ),
            const Positioned(
              top: -50,
              left: 0,
              right: 0,
              child: CustomCheckIcon(),
            ),
          ],
        ),
      ),
    );
  }
}
