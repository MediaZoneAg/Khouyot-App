import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/filter_categorie_model.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class CategoryFilterItem extends StatelessWidget {
  final bool isSelected;
  final FilterCategorieModel parentCategoryModel;
  final VoidCallback onTap;

  const CategoryFilterItem({
    super.key,
    required this.parentCategoryModel,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        height: 40.h,
        decoration: BoxDecoration(
            color:
                isSelected ? ColorsManager.kPrimaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color:
                  isSelected ? ColorsManager.kPrimaryColor : ColorsManager.grey,
            )),
        child: Text(
          parentCategoryModel.data?.first.name ?? '',
          style: isSelected
              ? TextStyles.font14WhiteRegular
              : TextStyles.font14DarkGreyRegular,
        ),
      ),
    );
  }
}
