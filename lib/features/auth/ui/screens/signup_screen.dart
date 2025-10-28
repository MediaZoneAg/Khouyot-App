import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/features/auth/data/models/sign_up_model.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/auth/ui/widgets/dont_have_account_text.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_text.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_up_state_ui.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_with_body.dart';
import 'package:khouyot/features/auth/ui/widgets/terms_and_conditions_text.dart';
import 'package:khouyot/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController conPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool success = false;
  final FocusNode passwordFocusNode = FocusNode();
  bool showPasswordValidator = false;

  @override
  void initState() {
    super.initState();
    passwordFocusNode.addListener(() {
      AuthCubit.get(context)
          .togglePasswordValidator(passwordFocusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    conPasswordController.dispose();
    super.dispose();
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    verticalSpace(15),
                    Text(
                      S.of(context).CreateAccount,
                      style: TextStyles.font24KprimaryMedium,
                    ),
                    Text(
                      S.of(context).SignUpDes,
                      style: TextStyles.font14BlackRegular.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? ColorsManager.black
                                : ColorsManager.mainWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace(10),
                          Text(
                            S.of(context).Name,
                            style: TextStyles.font16BlackRegular.copyWith(
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.black
                                  : ColorsManager.mainWhite,
                            ),
                          ),
                          verticalSpace(5),
                          AppTextFormField(
                            controller: nameController,
                            hintText: S.of(context).Enteryourname,
                            borderRadius: 10.r,
                            hintStyle: TextStyles.font14BlackRegular.copyWith(
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.black
                                  : ColorsManager.grey,
                            ),
                            inputTextStyle: TextStyles.font16BlackRegular,
                            backgroundColor: Colors.transparent,
                            contentPadding: EdgeInsets.all(14.h),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).namecannotbeempty;
                              }
                              return null;
                            },
                          ),
                          verticalSpace(12),
                          Text(
                            S.of(context).Email,
                            style: TextStyles.font16BlackRegular.copyWith(
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.black
                                  : ColorsManager.mainWhite,
                            ),
                          ),
                          verticalSpace(5),
                          AppTextFormField(
                            controller: emailController,
                            hintText: S.of(context).Enteryouremail,
                            borderRadius: 10.r,
                            inputTextStyle: TextStyles.font16BlackRegular,
                            hintStyle: TextStyles.font14BlackRegular.copyWith(
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.black
                                  : ColorsManager.grey,
                            ),
                            contentPadding: EdgeInsets.all(14.h),
                            backgroundColor:
                                Colors.transparent, //S.of(context).Password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).Emailcannotbeempty;
                              }
                              // Regular expression for email validation
                              final emailRegex = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                              if (!emailRegex.hasMatch(value)) {
                                return S.of(context).Enteravalidemailaddress;
                              }
                              return null;
                            },
                          ),
                          verticalSpace(12),
                          Text(
                            S.of(context).Password,
                            style: TextStyles.font16BlackRegular.copyWith(
                              color: ThemeCubit.get(context).themeMode ==
                                      ThemeMode.light
                                  ? ColorsManager.black
                                  : ColorsManager.mainWhite,
                            ),
                          ),
                          verticalSpace(5),
                          BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppTextFormField(
                                    controller: passwordController,
                                    hintText: S.of(context).Enteryourpassword,
                                    hintStyle:
                                        TextStyles.font14BlackRegular.copyWith(
                                      color:
                                          ThemeCubit.get(context).themeMode ==
                                                  ThemeMode.light
                                              ? ColorsManager.black
                                              : ColorsManager.grey,
                                    ),
                                    borderRadius: 10.r,
                                    inputTextStyle:
                                        TextStyles.font16BlackRegular,
                                    backgroundColor: Colors.transparent,
                                    contentPadding: EdgeInsets.all(14.h),
                                    focusNode: passwordFocusNode,
                                    isObscureText:
                                        AuthCubit.get(context).isObscureText1,
                                    suffixIcon: GestureDetector(
                                        onTap: () {
                                          AuthCubit.get(context).obscureText1();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 7.w),
                                          child: Icon(
                                            AuthCubit.get(context)
                                                    .isObscureText1
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 23.sp,
                                          ),
                                        )),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     return S.of(context).passwordcannotbeempty;
                                    //   }
                                    //   if (value.length < 7) {
                                    //     return S
                                    //         .of(context)
                                    //         .passwordmustbeatleast7characters;
                                    //   }
                                    //   // Regular expression for password validation
                                    //   final passwordRegex = RegExp(
                                    //       r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                    //   if (!passwordRegex.hasMatch(value)) {
                                    //     return '${S.of(context).PasswordMustbeUpperCaseLowerCase} \n ${S.of(context).AnumberAndAspecialCharacter}';
                                    //   }
                                    //   return null;
                                    // },
                                  ),
                                  verticalSpace(5),
                                  if (AuthCubit.get(context)
                                      .showPasswordValidator)
                                    FlutterPwValidator(
                                      defaultColor: Colors.grey,
                                      controller: passwordController,
                                      successColor: Colors.green.shade700,
                                      minLength: 8,
                                      uppercaseCharCount: 2,
                                      lowercaseCharCount: 2,
                                      numericCharCount: 3,
                                      specialCharCount: 1,
                                      width: 400.h,
                                      height: 170.h,
                                      failureColor: Colors.red.shade300,
                                      onSuccess: () {
                                        AuthCubit.get(context)
                                            .setPasswordValidationStatus(true);
                                      },
                                      onFail: () {
                                        AuthCubit.get(context)
                                            .setPasswordValidationStatus(false);
                                      },
                                    ),
                                  verticalSpace(12),
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
                                  verticalSpace(5),
                                  AppTextFormField(
                                    controller: conPasswordController,
                                    hintText: S.of(context).ConfirmPassword,
                                    hintStyle:
                                        TextStyles.font14BlackRegular.copyWith(
                                      color:
                                          ThemeCubit.get(context).themeMode ==
                                                  ThemeMode.light
                                              ? ColorsManager.black
                                              : ColorsManager.grey,
                                    ),
                                    borderRadius: 10.r,
                                    inputTextStyle:
                                        TextStyles.font16BlackRegular,
                                    backgroundColor: Colors.transparent,
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
                                            AuthCubit.get(context)
                                                    .isObscureText2
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 23.sp,
                                          ),
                                        )),
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
                          TermsAndConditionsText(
                            onTap: () async {
                              final Uri url = Uri.parse(
                                  'https://www.khoyoutscarfstores.com/privacy-policy/');
                              if (await launchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                throw 'Could not launch $url';
                              }
                            },
                          ),
                          verticalSpace(10),
                          AppTextButton(
                            buttonText: S.of(context).SignUp,
                            textStyle: TextStyles.font20WhiteMedium,
                            //verticalPadding: 3,
                            buttonHeight: 40.h,
                            borderRadius: 10.r,
                            onPressed: () async {
                              if (AuthCubit.get(context).isChecked == true) {
                                if (formKey.currentState!.validate()) {
                                  await AuthCubit.get(context)
                                      .signUp(SignUpModel(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                  ));
                                  //context.pushReplacementNamed(Routes.navigationBar);
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: S
                                      .of(context)
                                      .PleaseCheckTermsAndConditions,
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: ColorsManager.kPrimaryColor,
                                  textColor: Colors.white,
                                  fontSize: 16.0,
                                );
                              }
                            },
                            backgroundColor: ColorsManager.kPrimaryColor,
                          ),
                          verticalSpace(20),
                          SignText(
                            text: S.of(context).Orsignupwith,
                          ),
                          verticalSpace(20),
                          const SignWithBody(),
                          verticalSpace(15),
                          Center(
                            child: DontHaveAccountText(
                              text1: S.of(context).Alreadyhaveanaccount,
                              text2: S.of(context).SignIn,
                              onTap: () {
                                context
                                    .pushReplacementNamed(Routes.signInScreen);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SignUpStateUi()
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
