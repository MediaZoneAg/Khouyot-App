import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/networking/dio_factory.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/utils/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    tohome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          body: SafeArea(
              child: Center(
                  child: TweenAnimationBuilder(
                      tween: Tween(begin: 50.0, end: 300.0),
                      curve: Curves.easeIn,
                      duration: const Duration(seconds: 1),
                      builder:
                          (BuildContext context, dynamic value, Widget? child) {
                        return Container(
                          height: value,
                          width: value,
                          child: Image.asset(AssetsData.logo),
                        );
                      }))),
        );
      },
    );
  }

  void tohome() {
    Future.delayed(const Duration(seconds: 2), () async {
      String token = await CashHelper.getStringSecured(key: Keys.token);
      if (token == '') {
        context.pushReplacementNamed(Routes.enteranceScreen);
      } else {
        DioFactory.setTokenIntoHeaderAfterLogin(token);
        context.pushReplacementNamed(Routes.navigationBar);
      }
    });
  }
}
