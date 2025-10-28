import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/features/location/ui/widgets/location_container.dart';
import 'package:khouyot/generated/l10n.dart';

class SavedAddressScreen extends StatefulWidget {
  const SavedAddressScreen({super.key});

  @override
  State<SavedAddressScreen> createState() => _SavedAddressScreenState();
}

class _SavedAddressScreenState extends State<SavedAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              children: [
                CustomAppBar(
                    barIcon: Icons.arrow_back_ios,
                    onPressed: () {
                      context.pop();
                    },
                    title: S.of(context).SaveAddress),
                verticalSpace(30),
                SizedBox(
                    height: 600,
                    child: ListView.builder(
                        itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: LocationContainer(
                                location:
                                    "${CashHelper.getString(key: Keys.city)} ,${CashHelper.getString(key: Keys.address)},${CashHelper.getString(key: Keys.floor)}",
                              ),
                            ),
                        itemCount: 3)),
                AppTextButton(
                  buttonText: S.of(context).Addaddress,
                  textStyle: TextStyles.font20WhiteMedium,
                  //verticalPadding: 3,
                  buttonWidth: 250.w,
                  buttonHeight: 40.h,
                  borderRadius: 10.r,
                  onPressed: () {
                    //context.pushNamed(Routes.savedAddressScreen);
                  },
                  backgroundColor: ColorsManager.kPrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
