import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/numbers.dart';

extension SnackBarExtension on BuildContext {
  void showSnackBar({required String message}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.red,
        showCloseIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kDefaultBorderRadius),
        ),
      ),
    );
  }
}
