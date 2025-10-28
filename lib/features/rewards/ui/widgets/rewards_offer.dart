import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';

class RewardsOffer extends StatelessWidget {
  const RewardsOffer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(left: 16.w, top: 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(AssetsData.girl,
                  width: 155.w, height: 161.h, fit: BoxFit.cover),
              SizedBox(height: 5.h),
              Text(
                'Redeem & Get 50%\noff on chiffon hijab',
                style: TextStyles.font16BlackMedium.copyWith(
                  color: ThemeCubit.get(context).themeMode == ThemeMode.light
                      ? ColorsManager.black
                      : ColorsManager.mainWhite,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 5.h),
              Text('25 Points', style: TextStyles.font16KprimaryRegular),
            ],
          ),
        );
      },
    );
  }
}
