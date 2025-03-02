import 'package:flutter/material.dart';
import 'package:recipe_app/resources/color_code.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: ColorCode.kwhite,
    primary: ColorCode.mainColor,
    secondary: ColorCode.black,
  ),
);
ThemeData darkMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: ColorCode.black,
    primary: ColorCode.mainColor,
    secondary: ColorCode.kwhite,
  ),
);
