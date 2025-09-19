// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData customTheme() {
  Color primaryColor = Colors.blue;
  return ThemeData(
    // 앱바 타이틀 색상
    appBarTheme: AppBarTheme(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 24,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      // 버튼 스타일
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        minimumSize: const Size(
          140,
          60,
        ),
      ),
    ),
  );
}
