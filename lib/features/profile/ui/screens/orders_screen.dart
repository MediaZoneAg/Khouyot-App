import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:lottie/lottie.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                        barIcon: Icons.arrow_back_ios,
                        onPressed: () {
                          context.pop();
                        },
                        title: 'Orders'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 120.0),
                      child: Lottie.asset(AssetsData.empty),
                    ),
                    // Expanded(
                    //     child: ListView.builder(
                    //   itemBuilder: (context, index) => const OrdersItem(
                    //     image:
                    //         'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR8rHkK301LBCvaTWN5TnJbc4t5h0Cnzxm1tQ&s',
                    //     name: 'ggggg',
                    //     price: '3333',
                    //     rate: '222',
                    //   ),
                    //   itemCount: 3,
                    // ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
