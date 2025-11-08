import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thb/common/app_color.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.obscureText,
    this.readOnly,
    this.maxLines,
    this.onTap,
    this.initialValue,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintStyle,
    this.maxLength,
  });

  final String hintText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final int? maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final String? initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      cursorHeight: 20,
      cursorWidth: 1,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      initialValue: initialValue,
      style: const TextStyle(fontSize: 13, color: AppColors.fontOffWhiteColor),
      cursorColor: AppColors.offWhite,
      cursorErrorColor: AppColors.offWhite,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      maxLines: maxLines ?? 1,
      maxLength: maxLength,
      inputFormatters:
          inputFormatters ?? [FilteringTextInputFormatter.deny(RegExp(r'^\s'))],
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        hintStyle:
            hintStyle ?? TextStyle(fontSize: 12, color: AppColors.greyColor),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: readOnly == true ? true : null,
        fillColor: readOnly == true
            ? AppColors.greyColor.withOpacity(0.02)
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.offWhite),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 12.0,
        ),
      ),
    );
  }
}
