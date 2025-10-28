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
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/auth/ui/widgets/forget_password_stata_ui.dart';
import 'package:khouyot/generated/l10n.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void dispose() {
    super.dispose();
    emailController.dispose();
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
                CustomAppBar(
                  barIcon: Icons.arrow_back_ios,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: S.of(context).back,
                ),
                verticalSpace(30),
                Text(
                  S.of(context).ForgotPassword,
                  style: TextStyles.font24KprimaryMedium,
                ),
                Text(
                  S.of(context).Enteryouremail,
                  style: TextStyles.font14KprimaryRegular,
                  textAlign: TextAlign.center,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(18),
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
                          inputTextStyle: TextStyles.font16WhiteRegular,
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
                        verticalSpace(100),
                        AppTextButton(
                          buttonText: S.of(context).next, //S.of(context).Login,
                          textStyle: TextStyles.font20WhiteMedium,
                          //verticalPadding: 3,
                          buttonHeight: 40.h,
                          borderRadius: 10.r,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              await CashHelper.putString(
                                key: Keys.email,
                                value: emailController.text,
                              );
                              await AuthCubit.get(context)
                                  .forgetPaswword(emailController.text);
                            }
                          },
                          backgroundColor: ColorsManager.kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const ForgetPasswordStateUi(),
              ],
            ),
          )),
        );
      },
    );
  }
}
