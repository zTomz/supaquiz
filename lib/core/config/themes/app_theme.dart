import 'package:flutter/material.dart';

import 'light_color_scheme.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: lightColorScheme,
  );

  // static ThemeData darkTheme = ThemeData(
  //   colorScheme: darkColorScheme,
  // );
}
