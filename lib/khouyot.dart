import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/localization/cubit/localization_cubit.dart';
import 'package:khouyot/core/routing/app_router.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/features/nav_bar/logic/nav_bar_cubit.dart';
import 'package:khouyot/generated/l10n.dart';

class khouyot extends StatelessWidget {
  const khouyot({super.key, required this.appRouter});
  final AppRouter appRouter;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocalizationCubit()),
        BlocProvider(create: (_) => NavBarCubit()),
        BlocProvider(create: (_) {
          final themeCubit = ThemeCubit();
          themeCubit.loadTheme();
          return themeCubit;
        }),
      ],
      child: ScreenUtilInit(
        //designSize: const Size(375, 812),
        minTextAdapt: true,
        child: BlocBuilder<LocalizationCubit, LocalizationState>(
          builder: (context, localizationState) {
            // Determine the current locale
            // Locale currentLocale;
            // if (localizationState is LocalizationChanged) {
            //   currentLocale = localizationState.locale;
            // } else {
            //   // Provide a default locale if no selection has been made
            //   currentLocale = ui.window.locale; // Default to English
            // }
            return BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  locale: LocalizationCubit.get(context).locale,
                  navigatorKey: NavigationService.navigatorKey,
                  theme: themeState.themeMode == ThemeMode.light
                      ? ThemeData.light(useMaterial3: true)
                      : ThemeData.dark(useMaterial3: true),
                  // theme: ThemeData.light().copyWith(
                  // textTheme: GoogleFonts.montserratTextTheme(ThemeData.light().textTheme),
                  // ),
                  initialRoute: Routes.splashScreen,
                  onGenerateRoute: appRouter.generateRoute,
                  supportedLocales: const [
                    Locale('en'),
                    Locale('ar'),
                  ],
                  localizationsDelegates: const [
                    S.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  debugShowCheckedModeBanner: false,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
