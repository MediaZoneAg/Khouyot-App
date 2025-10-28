import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/features/profile/data/models/change_password_model.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/profile/ui/widgets/change_pasword_state_ui.dart';
import 'package:khouyot/generated/l10n.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void dispose() {
    super.dispose();
    newPasswordController.dispose();
    oldPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.h),
            child: Column(
              children: [
                CustomAppBar(
                    barIcon: Icons.arrow_back_ios,
                    onPressed: () {
                      context.pop();
                    },
                    title: S.of(context).ChangePassword),
                verticalSpace(30),
                Text(
                  S.of(context).Newpassword,
                  style: TextStyles.font24KprimaryMedium,
                ),
                Text(
                  S.of(context).NewpasswordDes,
                  style: TextStyles.font14KprimaryRegular,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(30),
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(10),
                        BlocBuilder<ProfileCubit, ProfileState>(
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  S.of(context).OldPassword,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                AppTextFormField(
                                  controller: oldPasswordController,
                                  hintText: S.of(context).Enteryouroldpassword,
                                  hintStyle: TextStyles.font14DarkGreyRegular,
                                  borderRadius: 10.r,
                                  inputTextStyle: TextStyles.font16BlackRegular,
                                  backgroundColor: Colors.transparent,
                                  contentPadding: EdgeInsets.all(14.h),
                                  isObscureText:
                                      ProfileCubit.get(context).isObscureText1,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      ProfileCubit.get(context).obscureText1();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 7.w),
                                      child: Icon(
                                        ProfileCubit.get(context).isObscureText1
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
                                  S.of(context).Newpassword,
                                  style: TextStyles.font16BlackRegular,
                                ),
                                verticalSpace(5),
                                AppTextFormField(
                                  controller: newPasswordController,
                                  hintText: S.of(context).Enteryournewpassword,
                                  borderRadius: 10.r,
                                  hintStyle: TextStyles.font14DarkGreyRegular,
                                  inputTextStyle: TextStyles.font16BlackRegular,
                                  backgroundColor: Colors.transparent,
                                  contentPadding: EdgeInsets.all(14.h),
                                  isObscureText:
                                      ProfileCubit.get(context).isObscureText1,
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      ProfileCubit.get(context).obscureText1();
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 7.w),
                                      child: Icon(
                                        ProfileCubit.get(context).isObscureText1
                                            ? Icons.visibility_off
                                            : Icons.visibility,
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
                              ],
                            );
                          },
                        ),
                        verticalSpace(70),
                        AppTextButton(
                          buttonText:
                              S.of(context).Done, // S.of(context).Login,
                          textStyle: TextStyles.font20WhiteMedium,
                          //verticalPadding: 3,
                          buttonHeight: 40.h,
                          borderRadius: 10.r,
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              ProfileCubit.get(context).changePassword(
                                  ChangePaswwordModel(
                                      newPassword: newPasswordController.text,
                                      oldPassword: oldPasswordController.text));
                            }
                          },
                          backgroundColor: ColorsManager.kPrimaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const ChangePasswordStateUi(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
