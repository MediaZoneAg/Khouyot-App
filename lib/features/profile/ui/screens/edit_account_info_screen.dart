import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/helpers/extensions.dart';
import 'package:khouyot/core/helpers/spacing.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/core/theming/colors.dart';
import 'package:khouyot/core/theming/styles.dart';
import 'package:khouyot/core/utils/assets.dart';
import 'package:khouyot/core/widgets/app_text_button.dart';
import 'package:khouyot/core/widgets/app_text_form_field.dart';
import 'package:khouyot/core/widgets/custom_app_bar.dart';
import 'package:khouyot/features/profile/data/models/edit_profile_model.dart';
import 'package:khouyot/features/profile/logic/profile_cubit.dart';
import 'package:khouyot/features/profile/ui/widgets/edit_profile_state_ui.dart';
import 'package:khouyot/generated/l10n.dart';

class EditAccountInfoScreen extends StatefulWidget {
  const EditAccountInfoScreen({super.key});

  @override
  State<EditAccountInfoScreen> createState() => _EditAccountInfoScreenState();
}

class _EditAccountInfoScreenState extends State<EditAccountInfoScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomAppBar(
                        barIcon: Icons.arrow_back_ios,
                        onPressed: () {
                          context.pop();
                        },
                        title: S.of(context).Editaccountinfo),
                    verticalSpace(30),
                    CircleAvatar(
                        radius: 50.r,
                        backgroundImage:
                            const AssetImage(AssetsData.profileImage)),
                    verticalSpace(16),
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).Name,
                              style: TextStyles.font16BlackRegular.copyWith(
                                  color: ThemeCubit.get(context).themeMode ==
                                          ThemeMode.light
                                      ? Colors.black
                                      : ColorsManager.mainWhite),
                            ),
                            verticalSpace(5),
                            AppTextFormField(
                              controller: nameController,
                              hintText: S.of(context).Enteryourname,
                              inputTextStyle: TextStyles.font16BlackRegular
                                  .copyWith(
                                      color:
                                          ThemeCubit.get(context).themeMode ==
                                                  ThemeMode.light
                                              ? Colors.black
                                              : ColorsManager.mainWhite),
                              hintStyle: TextStyles.font14BlackRegular.copyWith(
                                  color: ThemeCubit.get(context).themeMode ==
                                          ThemeMode.light
                                      ? Colors.black
                                      : ColorsManager.mainWhite),
                              contentPadding: EdgeInsets.all(12.h),
                              backgroundColor:
                                  Colors.transparent, //S.of(context).Password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).namecannotbeempty;
                                }
                                return null;
                              },
                            ),
                            verticalSpace(20),
                            Text(S.of(context).Email,
                                style: TextStyles.font16BlackRegular.copyWith(
                                    color: ThemeCubit.get(context).themeMode ==
                                            ThemeMode.light
                                        ? Colors.black
                                        : ColorsManager.mainWhite)),
                            verticalSpace(5),
                            AppTextFormField(
                              controller: emailController,
                              hintText: S.of(context).Enteryouremail,
                              inputTextStyle: TextStyles.font16BlackRegular
                                  .copyWith(
                                      color:
                                          ThemeCubit.get(context).themeMode ==
                                                  ThemeMode.light
                                              ? Colors.black
                                              : ColorsManager.mainWhite),
                              hintStyle: TextStyles.font14BlackRegular.copyWith(
                                  color: ThemeCubit.get(context).themeMode ==
                                          ThemeMode.light
                                      ? Colors.black
                                      : ColorsManager.mainWhite),
                              contentPadding: EdgeInsets.all(12.h),
                              backgroundColor:
                                  Colors.transparent, //S.of(context).Password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return S.of(context).Emailcannotbeempty;
                                }
                                return null;
                              },
                            ),
                            verticalSpace(34),
                            AppTextButton(
                              buttonText: S.of(context).Done,
                              textStyle: TextStyles.font20WhiteMedium,
                              //verticalPadding: 3,
                              buttonHeight: 35.h,
                              borderRadius: 10.r,
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await ProfileCubit.get(context)
                                      .editProfile(EditProfileModel(
                                    name: nameController.text.trim(),
                                    email: emailController.text.trim(),
                                  ));
                                }
                              },
                              backgroundColor: ColorsManager.kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const EditProfileStateUi(),
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
