import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/action_button.dart';
import 'package:khouyot/features/home/logic/home_cubit.dart';

class IncreamDecream extends StatelessWidget {
  const IncreamDecream({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quantity',
              style: TextStyles.font16BlackRegular.copyWith(
                color: ThemeCubit.get(context).themeMode == ThemeMode.light
                    ? ColorsManager.black
                    : ColorsManager.mainWhite,
              ),
            ),
            verticalSpace(10),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                  ), //EdgeInsets.all(8.0),
                  child: Row(children: [
                    ActionButton(
                        onTap: () {
                          HomeCubit.get(context).decrement();
                        },
                        iconContent: Icons.remove),
                    horizontalSpace(20),
                    Text('${HomeCubit.get(context).num}',
                        style: TextStyles.font18BlackMedium.copyWith(
                          color: ThemeCubit.get(context).themeMode ==
                                  ThemeMode.light
                              ? ColorsManager.black
                              : ColorsManager.mainWhite,
                        )),
                    horizontalSpace(20),
                    ActionButton(
                        onTap: () {
                          HomeCubit.get(context).increment();
                        },
                        iconContent: Icons.add),
                  ]),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
