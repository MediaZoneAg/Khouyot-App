import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/features/auth/data/models/reset_password_model.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/auth/ui/widgets/reset_password_state_ui.dart';
import 'package:khouyot/generated/l10n.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void dispose() {
    super.dispose();
    conPasswordController.dispose();
    passwordController.dispose();
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpace(20),
                  Text(
                    S.of(context).Newpassword,
                    style: TextStyles.font24KprimaryMedium,
                  ),
                  Text(
                    S.of(context).NewpasswordDes,
                    style: TextStyles.font14KprimaryRegular,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(20),
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(23),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).Newpassword,
                                    style:
                                        TextStyles.font16BlackRegular.copyWith(
                                      color:
                                          ThemeCubit.get(context).themeMode ==
                                                  ThemeMode.light
                                              ? ColorsManager.black
                                              : ColorsManager.mainWhite,
                                    ),
                                  ),
                                  verticalSpace(10),
                                  AppTextFormField(
                                    controller: passwordController,
                                    hintText: S.of(context).Enteryourpassword,
                                    hintStyle: TextStyles.font14Grey,
                                    borderRadius: 10.r,
                                    inputTextStyle:
                                        TextStyles.font16BlackRegular,
                                    contentPadding: EdgeInsets.all(14.h),
                                    backgroundColor: Colors.transparent,
                                    isObscureText:
                                        AuthCubit.get(context).isObscureText1,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        AuthCubit.get(context).obscureText1();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 7.w),
                                        child: Icon(
                                          AuthCubit.get(context).isObscureText1
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: 23.sp,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return S
                                            .of(context)
                                            .passwordcannotbeempty;
                                      }

                                      return null;
                                    },
                                  ),
                                  verticalSpace(20),
                                  Text(
                                    S.of(context).ConfirmPassword,
                                    style:
                                        TextStyles.font16BlackRegular.copyWith(
                                      color:
                                          ThemeCubit.get(context).themeMode ==
                                                  ThemeMode.light
                                              ? ColorsManager.black
                                              : ColorsManager.mainWhite,
                                    ),
                                  ),
                                  verticalSpace(10),
                                  AppTextFormField(
                                    controller: conPasswordController,
                                    hintText: S.of(context).ConfirmPassword,
                                    hintStyle: TextStyles.font14Grey,
                                    inputTextStyle:
                                        TextStyles.font16BlackRegular,
                                    backgroundColor: Colors.transparent,
                                    borderRadius: 10.r,
                                    contentPadding: EdgeInsets.all(14.h),
                                    isObscureText:
                                        AuthCubit.get(context).isObscureText2,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        AuthCubit.get(context).obscureText2();
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 7.w),
                                        child: Icon(
                                          AuthCubit.get(context).isObscureText2
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: 23.sp,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return S
                                            .of(context)
                                            .passwordcannotbeempty;
                                      } else if (passwordController.text !=
                                          conPasswordController.text) {
                                        return S
                                            .of(context)
                                            .Passwordsarentidentical;
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          verticalSpace(50),
                          AppTextButton(
                            buttonText:
                                S.of(context).Done, // S.of(context).Login,
                            textStyle: TextStyles.font20WhiteMedium,
                            //verticalPadding: 3,
                            buttonHeight: 40.h,
                            borderRadius: 10.r,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                context
                                    .read<AuthCubit>()
                                    .resetPassword(ResetPasswordModel(
                                      password: passwordController.text,
                                      email:
                                          CashHelper.getString(key: Keys.email),
                                      secretKey:
                                          await CashHelper.getStringSecured(
                                              key: Keys.secretKey),
                                    ));
                              }
                            },
                            backgroundColor: ColorsManager.kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const ResetPasswordStateUi(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
