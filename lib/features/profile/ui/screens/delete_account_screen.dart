import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/font_weight.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/profile/ui/widgets/delete_account_state_ui.dart';
import 'package:khouyot/generated/l10n.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.mainWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 150),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_rounded,
                      color: Colors.red, size: 25 // Adjust size to your liking
                      ),
                  horizontalSpace(3),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0.h),
                    child: Text(S.of(context).Deletingyouraccountwill,
                        style: TextStyles.font16BlackMedium),
                  ),
                ],
              ),
              verticalSpace(
                15,
              ),
              Text(
                "- ${S.of(context).Deleteyouraccountinfo}\n"
                "- ${S.of(context).Removeallyourdata}\n"
                "- ${S.of(context).Deleteyourhistory}\n",
                style: TextStyles.font14BlackMedium
                    .copyWith(fontWeight: FontWeightHelper.regular),
              ),
              verticalSpace(50),
              AppTextButton(
                buttonText: S.of(context).DeleteYourAccount,
                textStyle:
                    TextStyles.font18WhiteMedium.copyWith(color: Colors.white),
                onPressed: () {
                  ProfileCubit.get(context).deletUserAccount();
                },
                buttonWidth: 330.w,
                buttonHeight: 54.h,
                borderRadius: 10.r,
                //verticalPadding: 10,
              ),
              verticalSpace(10),
              AppTextButton(
                buttonText: S.of(context).Cancel,
                textStyle:
                    TextStyles.font18WhiteMedium.copyWith(color: Colors.white),
                onPressed: () {
                  context.pop();
                },
                buttonWidth: 330.w,
                buttonHeight: 54.h,
                borderRadius: 10.r,
              ),
              const DeleteAccountStateUi(),
            ],
          ),
        ),
      ),
    );
  }
}
