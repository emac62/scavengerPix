import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final double r = color.r, g = color.g, b = color.b;
  final int roundedR = r.round();
  final int roundedG = g.round();
  final int roundedB = b.round();

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      roundedR + ((ds < 0 ? r : (255 - r)) * ds).round(),
      roundedG + ((ds < 0 ? g : (255 - g)) * ds).round(),
      roundedB + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.toARGB32(), swatch);
}
