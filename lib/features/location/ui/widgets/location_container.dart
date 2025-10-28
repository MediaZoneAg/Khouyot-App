import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_svg.dart';

class LocationContainer extends StatelessWidget {
  const LocationContainer({super.key, required this.location});
  final String location;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //height: 100.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: ColorsManager.grey,
              )),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CustomSvg(imgPath: AssetsData.loccationIcon),
                      horizontalSpace(10),
                      Text('Location', style: TextStyles.font14DarkGreyRegular),
                    ],
                  ),
                  verticalSpace(15),
                  SizedBox(
                      width: 230.w,
                      child: Text(
                        location,
                        style: TextStyles.font14BlackRegular.copyWith(
                            color: ThemeCubit.get(context).themeMode ==
                                    ThemeMode.light
                                ? Colors.black
                                : ColorsManager.mainWhite),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                ],
              ),
              const Spacer(),
              Text('Change', style: TextStyles.font14DarkBlueRegular),
            ],
          ),
        );
      },
    );
  }
}
