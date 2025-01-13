import 'package:flutter/material.dart';

import '../app/config/constant_config.dart';
import '../app/theme/app_colors.dart';
import '../app/theme/font_style.dart';

class InputTextfield extends StatelessWidget {
  const InputTextfield({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    required this.leading,
    this.obscure = false,
    this.trailing,
    this.isEmail = false,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final Widget leading;
  final bool obscure;
  final Widget? trailing;
  final bool isEmail;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscure,
      validator: isEmail
          ? (value) {
              RegExp regex = RegExp(ConstantConfig.emailPattern);
              if (value == null || value.isEmpty) {
                return "This field is required";
              } else if (!regex.hasMatch(value)) {
                return "Please enter a valid email address";
              }
              return null;
            }
          : (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              }
              return null;
            },
      decoration: InputDecoration(
          hintText: hint,
          icon: leading,
          // suffixIcon: trailing,
          suffix: trailing,
          suffixStyle: AppFontStyle.boldFont(color: Colors.black),
          hintStyle: AppFontStyle.normalFont(),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.textInputFieldBorder),
          ),
          focusColor: AppColors.textInputFieldBorder,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.textInputFieldBorder)),
          errorBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.red))),
    );
  }
}
