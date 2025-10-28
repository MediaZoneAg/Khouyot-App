import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/features/search/ui/widgets/filter_button.dart';
import 'package:khouyot/features/search/ui/widgets/search_app_bar.dart';
import 'package:khouyot/features/search/ui/widgets/search_grid_view.dart';

class FilterResults extends StatelessWidget {
  const FilterResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 5.w),
              child: SearchAppBar(
                title: 'Filter',
                barIcon: Icons.arrow_back_ios,
                onPressed: () => context.pop(),
                onTap: () {},
              ),
            ),
            verticalSpace(10),
            const FilterButton(),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                left: 25.w,
                right: 25.w,
                top: 10.h,
              ),
              child: const SearchGridView(),
            )),
          ],
        ),
      ),
    );
  }
}
