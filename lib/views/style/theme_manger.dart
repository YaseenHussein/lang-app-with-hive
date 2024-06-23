import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_lang_app/views/style/color_manger.dart';

abstract class ThemeManger {
  static ThemeData getTheme() {
    return ThemeData(
      scaffoldBackgroundColor: ColorManger.black,
      appBarTheme: AppBarTheme(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: ColorManger.black),
        backgroundColor: ColorManger.black,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: ColorManger.white,
          fontWeight: FontWeight.bold,
          fontSize: 21,
        ),
      ),
    );
  }
}
