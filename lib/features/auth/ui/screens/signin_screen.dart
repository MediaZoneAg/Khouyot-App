import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/routing/routes.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/features/auth/data/models/sign_in_model.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/auth/ui/widgets/dont_have_account_text.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_in_state_ui.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_text.dart';
import 'package:khouyot/features/auth/ui/widgets/sign_with_body.dart';
import 'package:khouyot/generated/l10n.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    verticalSpace(30),
                    Text(
                      S.of(context).SignIn,
                      style: TextStyles.font24KprimaryMedium,
                    ),
                    Text(
                      S.of(context).SignInDes,
                      style: TextStyles.font14BlackRegular.copyWith(
                        color:
                            ThemeCubit.get(context).themeMode == ThemeMode.light
                                ? ColorsManager.black
                                : ColorsManager.mainWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace(15),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          verticalSpace(20),
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
                            hintStyle: TextStyles.font14DarkGreyRegular,
                            contentPadding: EdgeInsets.all(14.h),
                            backgroundColor:
                                Colors.transparent, //S.of(context).Password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return S.of(context).Emailcannotbeempty;
                              }
                              return null;
                            },
                          ),
                          verticalSpace(12),
                          Text(
                            //S.of(context).EnterPassword,
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
                              return AppTextFormField(
                                controller: passwordController,
                                hintText: S
                                    .of(context)
                                    .Enteryourpassword, //S.of(context).Password,
                                hintStyle: TextStyles.font14DarkGreyRegular,
                                borderRadius: 10.r,
                                inputTextStyle: TextStyles.font16BlackRegular,
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
                                        AuthCubit.get(context).isObscureText2
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        size: 23.sp,
                                      ),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return S.of(context).passwordcannotbeempty;
                                  }
                                  return null;
                                },
                              );
                            },
                          ),
                          verticalSpace(10),
                          Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .pushNamed(Routes.forgotPasswordScreen);
                                },
                                child: Text(
                                  S.of(context).ForgotPassword,
                                  style: TextStyles.font14KprimaryRegular,
                                ),
                              )),
                          verticalSpace(20),
                          AppTextButton(
                            buttonText:
                                S.of(context).SignIn, //S.of(context).Login,
                            textStyle: TextStyles.font20WhiteMedium,
                            //verticalPadding: 3,
                            buttonHeight: 40.h,
                            borderRadius: 10.r,
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await AuthCubit.get(context).signIn(SignInModel(
                                  email: emailController.text.trim(),
                                  username: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ));
                                //context.pushReplacementNamed(Routes.navigationBar);
                              }
                            },
                            backgroundColor: ColorsManager.kPrimaryColor,
                          ),
                          verticalSpace(20),
                          SignText(
                            text: S.of(context).Orsigninwith
                          
                          ),
                          verticalSpace(20),
                          const SignWithBody(),
                          verticalSpace(20),
                          Center(
                            child: DontHaveAccountText(
                              text1: S.of(context).Donthaveanaccount,
                              text2: S.of(context).SignUp,
                              onTap: () {
                                context
                                    .pushReplacementNamed(Routes.signUpScreen);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SignInStateUi(),
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
