import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';
import '../app/theme/font_style.dart';

class PaswordInputTextfield extends StatefulWidget {
  const PaswordInputTextfield({
    super.key,
    required this.controller,
    required this.focusNode, required this.hint,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  @override
  State<PaswordInputTextfield> createState() => _InputTextfieldState();
}

class _InputTextfieldState extends State<PaswordInputTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: widget. hint,
        hintStyle: AppFontStyle.normalFont(),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.textInputFieldBorder),
        ),
        focusColor: AppColors.textInputFieldBorder,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.textInputFieldBorder)),
      ),
    );
  }
}
