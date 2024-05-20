import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    primary: Colors.white,
    onPrimary: Colors.grey.shade100,
    secondary: Colors.grey.shade300,
    onSecondary: Colors.grey.shade300,
    outline: Colors.black,
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: const Color(0xff0d1b28),
    primary: const Color(0xff101418),
    onPrimary: Colors.grey.shade800,
    secondary: const Color(0xff101418),
    onSecondary: const Color(0xff0d1b28),
    outline: Colors.white,
  ),
);
