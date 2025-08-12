import 'package:flutter/material.dart';

import 'light_color.dart';

class AppTheme {
  const AppTheme();
  static ThemeData lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: LightColor.background,
    primaryColor: LightColor.purple,
    primaryColorDark: LightColor.Darker,
    primaryColorLight: LightColor.brighter,
    cardTheme: const CardThemeData(color: LightColor.background),
    iconTheme: const IconThemeData(color: LightColor.lightblack),
    dividerColor: LightColor.lightGrey,
    colorScheme: const ColorScheme(
        primary: LightColor.purple,
        primaryContainer: LightColor.purple,
        secondary: LightColor.lightBlue,
        secondaryContainer: LightColor.darkBlue,
        surface: LightColor.background,
        error: Colors.red,
        onPrimary: LightColor.Darker,
        onSecondary: LightColor.background,
        onSurface: LightColor.Darker,
        onError: LightColor.titleTextColor,
        brightness: Brightness.light),
  );
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: LightColor.background,
    primaryColor: LightColor.purple,
    primaryColorDark: LightColor.Darker,
    primaryColorLight: LightColor.brighter,
    cardTheme: const CardThemeData(color: LightColor.background),
    iconTheme: const IconThemeData(color: LightColor.lightblack),
    dividerColor: LightColor.lightGrey,
    colorScheme: const ColorScheme(
        primary: LightColor.purple,
        primaryContainer: LightColor.purple,
        secondary: LightColor.lightBlue,
        secondaryContainer: LightColor.darkBlue,
        surface: LightColor.background,
        error: Colors.red,
        onPrimary: LightColor.Darker,
        onSecondary: LightColor.background,
        onSurface: LightColor.Darker,
        onError: LightColor.titleTextColor,
        brightness: Brightness.dark),
  );

  static TextStyle titleStyle =
      const TextStyle(color: LightColor.titleTextColor, fontSize: 16);
  static TextStyle subTitleStyle =
      const TextStyle(color: LightColor.subTitleTextColor, fontSize: 12);

  static TextStyle h1Style =
      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  static TextStyle h2Style = const TextStyle(fontSize: 22);
  static TextStyle h3Style = const TextStyle(fontSize: 20);
  static TextStyle h4Style = const TextStyle(fontSize: 18);
  static TextStyle h5Style = const TextStyle(fontSize: 16);
  static TextStyle h6Style = const TextStyle(fontSize: 14);
}
