import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/numbers.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar({
    required String message,
    Color? background,
    Color? foreground,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: foreground),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: background ?? AppColors.red,
        showCloseIcon: true,
        closeIconColor: foreground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
    );
  }
}
