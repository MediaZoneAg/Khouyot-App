import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/models/filter_categorie_model.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';

class CategoriesItem extends StatelessWidget {
  final bool isSelected;
  final FilterCategorieModel parentCategoryModel;
  final VoidCallback onTap;

  const CategoriesItem({
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
        margin: EdgeInsets.symmetric(horizontal: 7.w),
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
        ),
        //height: 0.h,
        decoration: BoxDecoration(
            border: Border(
          bottom: isSelected
              ? const BorderSide(color: ColorsManager.kPrimaryColor)
              : const BorderSide(color: ColorsManager.grey),
        )),
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            return Center(
              child: Text(
                parentCategoryModel.data?.first.name ?? '',
                style: isSelected
                    ? TextStyles.font16BlackRegular.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? ColorsManager.black
                                : ColorsManager.mainWhite,
                      )
                    : TextStyles.font16DarkgreyRegular,
              ),
            );
          },
        ),
      ),
    );
  }
}
