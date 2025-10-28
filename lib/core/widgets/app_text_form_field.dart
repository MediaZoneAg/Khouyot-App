import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khouyot/core/theme/logic/theme_cubit.dart';
import 'package:khouyot/generated/l10n.dart';
import '../theming/colors.dart';
import '../theming/styles.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final double? borderRadius;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? prefexIcon;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final bool? readOnly;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.controller,
    this.validator,
    this.prefexIcon,
    this.onFieldSubmitted,
    this.readOnly,
    this.onTap,
    this.borderRadius,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      onFieldSubmitted: onFieldSubmitted,
      focusNode: focusNode,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(left: 20.w, right: 10.w, bottom: 32),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.kPrimaryColor,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
        ),
        hintStyle: hintStyle ?? TextStyles.font32BlueBold,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefexIcon,
        fillColor: backgroundColor ?? Colors.transparent,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.font16BlackRegular.copyWith(
        color: ThemeCubit.get(context).themeMode == ThemeMode.light
            ? ColorsManager.black
            : ColorsManager.mainWhite,
      ),
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).Mustnotbeempty;
            }
            return null;
          },
    );
  }
}
