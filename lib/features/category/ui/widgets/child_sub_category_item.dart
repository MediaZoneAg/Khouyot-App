import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/parent_category_model.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class ChildSubCategoriesItem extends StatelessWidget {
  final bool isSelected;
  final ParentCategoryModel parentCategoryModel;
  final VoidCallback onTap;

  const ChildSubCategoriesItem({
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
        margin: EdgeInsets.only(bottom: 20.w, right: 7.h, left: 7.h),
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        height: 44,
        decoration: BoxDecoration(
            //color: isSelected ? ColorsManager.kPrimaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ColorsManager.kPrimaryColor.withOpacity(.2),
            ),
            boxShadow: [
              BoxShadow(
                color: ColorsManager.lighKPrimaryColor.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ]),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Center(
              child: Text(
                parentCategoryModel.category?.name ?? '',
                style: TextStyles.font16DarkgreyRegular.copyWith(
                  color: ThemeCubit.get(context).themeMode == ThemeMode.light
                      ? ColorsManager.darkGrey
                      : ColorsManager.mainWhite,
                ),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      ),
    );
  }
}
