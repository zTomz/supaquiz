import 'package:flutter/material.dart';

import '../utils/constants/numbers.dart';

class SupaTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final String isEmptyError;
  final void Function(String)? onChanged;

  const SupaTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.isEmptyError,
    this.onChanged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: keyboardType == TextInputType.visiblePassword,
      onChanged: onChanged,
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
