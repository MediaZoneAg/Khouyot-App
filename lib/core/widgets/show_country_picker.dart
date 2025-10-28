import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';

class ShowCountry {
  static void openCountryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        ProfileCubit.get(context).updateSelectedCountry(country.name);
      },
    );
  }
}
