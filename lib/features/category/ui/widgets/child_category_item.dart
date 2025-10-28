import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/parent_category_model.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class ChildCategoriesItem extends StatelessWidget {
  final bool isSelected;
  final ParentCategoryModel parentCategoryModel;
  final VoidCallback onTap;

  const ChildCategoriesItem({
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
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 7.w),
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        height: 44,
        decoration: BoxDecoration(
            color:
                isSelected ? ColorsManager.kPrimaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? Colors.transparent : ColorsManager.grey,
            )),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Center(
              child: Text(
                parentCategoryModel.category?.name ?? '',
                style: isSelected
                    ? TextStyles.font16WhiteRegular
                    : TextStyles.font16DarkgreyRegular.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? ColorsManager.darkGrey
                                : ColorsManager.mainWhite,
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
