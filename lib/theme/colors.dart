import 'package:flutter/material.dart';

class CustomColor extends ThemeExtension<CustomColor> {
  final Color screenBackgroundColor;

  CustomColor({required this.screenBackgroundColor});

  @override
  ThemeExtension<CustomColor> copyWith({
    Color? cardTextColor,
    Color? cardBackgroundColor,
    Color? screenBackgroundColor,
  }) {
    return CustomColor(
      screenBackgroundColor:
          screenBackgroundColor ?? this.screenBackgroundColor,
    );
  }

  @override
  ThemeExtension<CustomColor> lerp(
    covariant ThemeExtension<CustomColor>? other,
    double t,
  ) {
    if (other is! CustomColor) return this;
    return CustomColor(
      screenBackgroundColor:
          Color.lerp(screenBackgroundColor, other.screenBackgroundColor, t)!,
    );
  }
}
