import 'package:flutter/material.dart';

import 'light_color_scheme.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontSize: 22,
        height: 1.1,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: lightColorScheme,
  );

  // static ThemeData darkTheme = ThemeData(
  //   colorScheme: darkColorScheme,
  // );
}
