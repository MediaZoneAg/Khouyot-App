// payment_option_tile.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';
import 'package:khouyot/generated/l10n.dart';

class FilterButton extends StatelessWidget {

  const FilterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: InkWell(
        onTap: () {
          context.pushNamed(Routes.filterScreen);
        },
        child: Container(
          height: 50.h,
          width: 91.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: ColorsManager.grey),
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomSvg(imgPath: AssetsData.slider),
              const Padding(padding: EdgeInsets.symmetric(horizontal: 5.0)),
              Text(S.of(context).filter, style: TextStyles.font16DarkgreyRegular)
          ])
        ),
      ),
    );
  }
}
