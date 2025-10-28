import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/db/cash_helper.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_otp_text_field.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/features/auth/data/models/otp_model.dart';
import 'package:khouyot/features/auth/logic/auth_cubit.dart';
import 'package:khouyot/features/auth/ui/widgets/otp_state_ui.dart';
import 'package:khouyot/generated/l10n.dart';

class VerifyCode extends StatefulWidget {
  const VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final formKey = GlobalKey<FormState>();

  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
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
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
            child: SafeArea(
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(50),
                      Text(S.of(context).verifycodeword,
                          style: TextStyles.font24KprimaryMedium),
                      Text(S.of(context).VerifyCodeDes,
                          style: TextStyles.font14BlackRegular.copyWith(
                            color: ThemeCubit.get(context).themeMode ==
                                    ThemeMode.light
                                ? ColorsManager.black
                                : ColorsManager.mainWhite,
                          )),
                      Text("${CashHelper.getString(key: Keys.email)}",
                          style: TextStyles.font14DarkBlueRegular),
                      verticalSpace(36),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            otpControllers.length,
                            (index) {
                              return OtpInputField(
                                controller: otpControllers[index],
                                focusNode: focusNodes[index],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "!!!!";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    AuthCubit.get(context)
                                        .focusPreviousField(context);
                                  } else {
                                    AuthCubit.get(context)
                                        .focusNextField(context);
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      verticalSpace(20),
                      Text(S.of(context).Dontreceivethecode,
                          style: TextStyles.font16DarkerGreyRegular.copyWith(
                            color: ThemeCubit.get(context).themeMode ==
                                    ThemeMode.light
                                ? ColorsManager.darkerGrey
                                : ColorsManager.mainWhite,
                          )),
                      AppTextButton(
                        buttonText: S.of(context).ResendCode,
                        textStyle: TextStyles.font16BlackRegular.copyWith(
                          color: ThemeCubit.get(context).themeMode ==
                                  ThemeMode.light
                              ? ColorsManager.darkerGrey
                              : ColorsManager.mainWhite,
                        ),
                        backgroundColor: Colors.transparent,
                        onPressed: () {
                          AuthCubit.get(context).clearOtpFields(otpControllers);
                          AuthCubit.get(context).resendCode(
                              "${CashHelper.getString(key: Keys.email)}");
                        },
                      ),
                      verticalSpace(30),
                      AppTextButton(
                        buttonText: S.of(context).Verify,
                        textStyle: TextStyles.font20WhiteMedium,
                        //verticalPadding: 3,
                        buttonHeight: 40.h,
                        borderRadius: 10.r,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //final otpValue = otpControllers.map((controller) => controller.text).join();
                            //CashHelper.putString(key: Keys.otpValue, value: otpValue);
                            AuthCubit.get(context).otp(OtpModel(
                              email: CashHelper.getString(key: Keys.email),
                              otp: otpControllers
                                  .map((controller) => controller.text)
                                  .join(),
                            ));
                          }
                        },
                        backgroundColor: ColorsManager.kPrimaryColor,
                      ),
                      const OtpStateUi(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
