import 'package:flutter/material.dart';
import 'package:flutter_scale_kit/flutter_scale_kit.dart';
import 'package:flutter_scale_theme_kit/flutter_scale_theme_kit.dart';

STTheme sampleTheme() {
  return STTheme(
    colors: STColors(
      primary: const STColor(light: Color(0xFF6750A4), dark: Color(0xFFD0BCFF)),
      surface: const STColor(light: Color(0xFFFFFFFF), dark: Color(0xFF1E1E1E)),
      background: const STColor(
        light: Color(0xFFF7F7F7),
        dark: Color(0xFF121212),
      ),
      text: const STColor(light: Color(0xFF1C1B1F), dark: Color(0xFFE6E1E5)),
    ),
  );
}

Widget wrapWithKits(Widget child) {
  return ScaleKitBuilder(
    designWidth: 375,
    designHeight: 812,
    child: MaterialApp(
      theme: sampleTheme().light,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: child,
        ),
      ),
    ),
  );
}
