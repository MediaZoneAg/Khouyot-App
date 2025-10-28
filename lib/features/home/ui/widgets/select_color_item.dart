import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class SelectColorItem extends StatelessWidget {
  const SelectColorItem(
      {super.key, required this.onTap, required this.selectedColor});

  final Function(Color) onTap;
  final Color selectedColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Color: ${_getColorName(selectedColor)}',
              style: TextStyles.font12BlackRegular.copyWith(
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? ColorsManager.darkBlack
                    : ColorsManager.mainWhite,
              ),
            ),
            verticalSpace(10),
            Row(
              children: _buildColorOptions(context),
            ),
          ],
        );
      },
    );
  }

  String _getColorName(Color color) {
    if (color == Colors.green) return "Green";
    if (color == Colors.blue) return "Blue";
    if (color == Colors.grey) return "Grey";
    if (color == Colors.yellow) return "Yellow";
    if (color == Colors.red) return "Red";
    return "Select color";
  }

  // Helper method to build color options as circular buttons
  List<Widget> _buildColorOptions(BuildContext context) {
    final colors = [
      Colors.green,
      Colors.blue,
      Colors.grey,
      Colors.yellow,
      Colors.red,
    ];

    return colors.map((color) {
      bool isSelected = selectedColor == color;
      return GestureDetector(
        onTap: () => onTap(color),

        //HomeCubit.get(context).changeSelectedColor(color),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? ColorsManager.grey : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: CircleAvatar(
            backgroundColor: color,
            radius: 13,
          ),
        ),
      );
    }).toList();
  }
}
