import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF0099FF);
  static const secondaryColor = Colors.blueGrey;
}

final ThemeData appTheme = ThemeData(
  fontFamily: 'Poppins',
  primarySwatch: Colors.blue,
  primaryColor: AppColors.primaryColor,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
    ),
  ),

);
