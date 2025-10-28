import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/core/widgets/phone_text_form.dart';
import 'package:khouyot/features/cart/data/models/billing_model.dart';
import 'package:khouyot/features/cart/data/models/shipping_model.dart';
import 'package:khouyot/features/cart/logic/cart_cubit.dart';
import 'package:khouyot/features/location/ui/widgets/choise_list_view.dart';
import 'package:khouyot/features/location/ui/widgets/location_container.dart';
import 'package:khouyot/generated/l10n.dart';

class LocationManualScreen extends StatefulWidget {
  const LocationManualScreen({super.key});

  @override
  State<LocationManualScreen> createState() => _LocationManualScreenState();
}

class _LocationManualScreenState extends State<LocationManualScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController floorController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ThemeCubit.get(context).themeMode == ThemeMode.light
              ? ColorsManager.mainWhite
              : ColorsManager.kSecondaryColor,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 10.h),
            child: AppTextButton(
              buttonText: S.of(context).SaveAddress,
              textStyle: TextStyles.font20WhiteMedium,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  CartCubit.get(context).shipping = Shipping(
                    address2: '',
                    firstName: fullNameController.text,
                    lastName: fullNameController.text,
                    address1: addressController.text,
                    city: cityController.text,
                    postcode: floorController.text,
                    state: '',
                    country: 'Egypt',
                  );
                  CartCubit.get(context).billing = Billing(
                    address2: '',
                    postcode: floorController.text,
                    firstName: fullNameController.text,
                    lastName: fullNameController.text,
                    address1: addressController.text,
                    city: cityController.text,
                    state: '',
                    country: 'Egypt',
                    phone: phoneNumberController.text,
                  );
                  CashHelper.putString(
                      key: Keys.address, value: addressController.text);
                  CashHelper.putString(
                      key: Keys.city, value: cityController.text);
                  CashHelper.putString(
                      key: Keys.floor, value: floorController.text);

                  context.pushNamed(Routes.checkOutScreen);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(S.of(context).pleaseFillAllFields)),
                  );
                }
              },

              //buttonWidth: 280.w,
              backgroundColor: ColorsManager.kPrimaryColor,
              //verticalPadding: 10.h,
              buttonHeight: 40.h,
              borderRadius: 10.r,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomAppBar(
                      barIcon: Icons.arrow_back_ios,
                      onPressed: () {
                        context.pop();
                      },
                      title: S.of(context).back),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      //vertical: 5,
                    ),
                    child: Column(
                      children: [
                        const LocationContainer(
                          location: ' 6 October ,Lorem ipsum dolor sit consect',
                        ),
                        verticalSpace(10),
                        const ChoiseListView(),
                        verticalSpace(10),
                        Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                S.of(context).CityName,
                                style: TextStyles.font16BlackRegular.copyWith(
                                    color: ThemeCubit.get(context).themeMode ==
                                            ThemeMode.light
                                        ? Colors.black
                                        : ColorsManager.mainWhite),
                              ),
                              verticalSpace(5),
                              AppTextFormField(
                                controller: cityController,
                                hintText: S.of(context).CityNameDes,
                                hintStyle: TextStyles.font14DarkGreyRegular,
                                inputTextStyle: TextStyles.font16BlackRegular,
                                backgroundColor: Colors.transparent,
                                contentPadding: EdgeInsets.all(15.h),
                                borderRadius: 10.r,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return S.of(context).pleaseFillAllFields;
                                  }
                                  return null;
                                },
                              ),
                              verticalSpace(15),
                              Text(
                                'Full Name',
                                style: TextStyles.font16BlackRegular.copyWith(
                                    color: ThemeCubit.get(context).themeMode ==
                                            ThemeMode.light
                                        ? Colors.black
                                        : ColorsManager.mainWhite),
                              ),
                              verticalSpace(5),
                              AppTextFormField(
                                controller: fullNameController,
                                hintText: S.of(context).EnterYourFullName,
                                hintStyle: TextStyles.font14DarkGreyRegular,
                                inputTextStyle: TextStyles.font16BlackRegular,
                                backgroundColor: Colors.transparent,
                                contentPadding: EdgeInsets.all(15.h),
                                borderRadius: 10.r,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).Namecannotbeempty;
                                  }
                                  return null;
                                },
                              ),
                              verticalSpace(15),
                              Text(
                                'Address',
                                style: TextStyles.font16BlackRegular.copyWith(
                                    color: ThemeCubit.get(context).themeMode ==
                                            ThemeMode.light
                                        ? Colors.black
                                        : ColorsManager.mainWhite),
                              ),
                              verticalSpace(5),
                              AppTextFormField(
                                controller: addressController,
                                hintText: S.of(context).BuildingNumberDes,
                                hintStyle: TextStyles.font14DarkGreyRegular,
                                inputTextStyle: TextStyles.font16BlackRegular,
                                backgroundColor: Colors.transparent,
                                contentPadding: EdgeInsets.all(15.h),
                                borderRadius: 10.r,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).addresscannotbeempty;
                                  }
                                  return null;
                                },
                              ),
                              verticalSpace(15),
                              horizontalSpace(15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).FloorNumber,
                                    style: TextStyles.font16BlackRegular
                                        .copyWith(
                                            color: ThemeCubit.get(context)
                                                        .themeMode ==
                                                    ThemeMode.light
                                                ? Colors.black
                                                : ColorsManager.mainWhite),
                                  ),
                                  verticalSpace(5),
                                  AppTextFormField(
                                    controller: floorController,
                                    hintText: S.of(context).FloorNumberDes,
                                    hintStyle: TextStyles.font14DarkGreyRegular,
                                    inputTextStyle:
                                        TextStyles.font16BlackRegular,
                                    backgroundColor: Colors.transparent,
                                    contentPadding: EdgeInsets.all(15.h),
                                    borderRadius: 10.r,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return S.of(context).floorcannotbeempty;
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                              verticalSpace(15),
                              Text(
                                S.of(context).PhoneNumber,
                                style: TextStyles.font16BlackRegular.copyWith(
                                    color: ThemeCubit.get(context).themeMode ==
                                            ThemeMode.light
                                        ? Colors.black
                                        : ColorsManager.mainWhite),
                              ),
                              verticalSpace(5),
                              PhoneTextForm(
                                onChanged: (String) {},
                                controller: phoneNumberController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).phonecannotbeempty;
                                  }
                                  return null;
                                },
                              ),
                              verticalSpace(5),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
