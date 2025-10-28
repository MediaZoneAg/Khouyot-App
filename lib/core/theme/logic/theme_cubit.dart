import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial(ThemeMode.system)); // Default to system theme

  static ThemeCubit get(BuildContext context) => BlocProvider.of(context);

  ThemeMode get themeMode => state.themeMode;

  ThemeData getTheme() {
    return themeMode == ThemeMode.light
        ? ThemeData.light(useMaterial3: true)
        : ThemeData.dark(useMaterial3: true);
  }

  Future<void> toggleTheme() async {
    ThemeMode newTheme = state.themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    emit(ThemeChanged(newTheme));

    // Save the selected theme in CashHelper
    await CashHelper.putString(key: Keys.theme, value: newTheme == ThemeMode.light ? 'light' : 'dark');
  }

  Future<void> loadTheme() async {
    // Load saved theme from CashHelper
    String? savedTheme = CashHelper.getString(key:Keys.theme);

    if (savedTheme == 'dark') {
      emit(ThemeChanged(ThemeMode.dark));
    } else {
      emit(ThemeChanged(ThemeMode.light));
    }
  }
}
