import 'package:flutter/material.dart';
import 'package:test5/theme/colors.dart';

final lightColorScheme = ColorScheme.fromSeed(seedColor: Colors.blue.shade300);
final lightCustomColors = CustomColor(
  screenBackgroundColor: Colors.grey.shade100,
);
final lightTheme = ThemeData.light().copyWith(
  colorScheme: lightColorScheme,
  extensions: [lightCustomColors],
  appBarTheme: AppBarTheme().copyWith(
    backgroundColor: lightColorScheme.primaryContainer,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: lightColorScheme.onSecondary,
    ),
  ),
);
