import 'package:etranzazct_test/app/theme/font_style.dart';
import 'package:flutter/material.dart';

import '../app/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.foregroundColor});
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          foregroundColor: foregroundColor,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: AppFontStyle.buttonFont()),
      child: Text(
        text,
      ),
    );
  }
}
