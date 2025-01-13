import 'package:flutter/material.dart';

void showToast(
  String message, {
  void Function()? onFunction,
  bool showCloseIcon = true,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      showCloseIcon: showCloseIcon,
      margin: const EdgeInsets.only(
          left: 5, right: 5, bottom: 10), // Adds margin around the snackbar
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      action: onFunction == null
          ? null
          : SnackBarAction(
              label: "OK",
              onPressed: onFunction,
            ),
    ),
  );
}
