import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class SelectSizeItem extends StatelessWidget {
  const SelectSizeItem(
      {super.key, required this.onTap, required this.selectedSize});
  final Function(String) onTap;
  final String selectedSize;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Size: ${selectedSize}',
                  style: TextStyles.font12BlackRegular.copyWith(
                    color: ThemeCubit.get(context).themeMode == ThemeMode.light
                        ? ColorsManager.darkBlack
                        : ColorsManager.mainWhite,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Download size guide',
                    style: TextStyles.font12DarkBlueRegular,
                  ),
                )
              ],
            ),
            verticalSpace(10),
            Row(children: _buildSizeOptions(context)),
          ],
        );
      },
    );
  }

  List<Widget> _buildSizeOptions(BuildContext context) {
    final sizes = ['S', 'M', 'L', 'XL'];

    return sizes.map((size) {
      bool isSelected =
          selectedSize == _getFullSizeName(size); // Compare with full names
      return GestureDetector(
        onTap: () => onTap(size),

        //HomeCubit.get(context).changeSelectedSize(size),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          padding: const EdgeInsets.all(8),
          // width: 32.w,
          // height: 32.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                isSelected ? ColorsManager.kPrimaryColor : Colors.transparent,
            border: Border.all(
              color: isSelected ? Colors.transparent : ColorsManager.grey,
              width: 1,
            ),
          ),
          child: Text(
            size,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : (ThemeCubit.get(context).themeMode == ThemeMode.light
                      ? ColorsManager.darkBlack
                      : ColorsManager.mainWhite),
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }).toList();
  }

  String _getFullSizeName(String abbreviation) {
    switch (abbreviation) {
      case 'S':
        return 'Small';
      case 'M':
        return 'Medium';
      case 'L':
        return 'Large';
      case 'XL':
        return 'Extra Large';
      default:
        return abbreviation;
    }
  }
}
