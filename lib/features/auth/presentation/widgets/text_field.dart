import 'package:flutter/material.dart';

import '../../../../core/utils/constants/numbers.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String isEmptyError;

  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.isEmptyError,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return isEmptyError;
        }

        return null;
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(kDefaultBorderRadius),
          ),
        ),
        labelText: label,
      ),
    );
  }
}
