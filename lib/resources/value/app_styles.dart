import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppStyles {

  // Light Theme
  static ThemeData lightTheme(){
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: AppColors.PRIMARY_COLOR,
      primaryColorLight: AppColors.PRIMARY_COLOR_LIGHT,
      primaryColorDark: AppColors.PRIMARY_COLOR_DARK,
      accentColor: AppColors.ACCENT_COLOR,
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(16),
        hintStyle: TextStyle(
          color: AppColors.GREY_LIGHT,
          fontWeight: FontWeight.normal,
        ),
        labelStyle: TextStyle(
          color: AppColors.PRIMARY_COLOR,
          fontWeight: FontWeight.bold,
        ),
        errorStyle: TextStyle(
          color: AppColors.RED,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.PRIMARY_COLOR_DARK,
              width: 2.5,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.PRIMARY_COLOR,
              width: 2.5,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.RED,
              width: 2.5,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2.5,
            ),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.0),
            topRight: Radius.circular(12.0),
          )
        ),
        textTheme:ButtonTextTheme.normal,
        buttonColor: AppColors.ACCENT_COLOR,
      ),
    );

  }

  static TextStyle appBarTextStyle = TextStyle(
      fontFamily: 'Uniform',
      fontSize: 20,
      color: AppColors.WHITE,
      fontWeight: FontWeight.w900);

  static TextStyle headerTextStyle = TextStyle(
      fontFamily: 'Uniform',
      fontSize: 20,
      color: AppColors.WHITE,
      fontWeight: FontWeight.w900);

static TextStyle buttonStyle = TextStyle(
      fontFamily: 'Uniform',
      fontSize: 14,
      color: AppColors.WHITE,
      fontWeight: FontWeight.w900);

  static TextStyle textButtonTextStyle = TextStyle(
      fontFamily: 'Uniform',
      color: AppColors.WHITE,
      fontSize: 14,
      decoration: TextDecoration.underline,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w300);

  // Dark Theme
  static ThemeData darkTheme(){
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: AppColors.PRIMARY_COLOR,
      primaryColorLight: AppColors.PRIMARY_COLOR_LIGHT,
      primaryColorDark: AppColors.PRIMARY_COLOR_DARK,
      accentColor: AppColors.ACCENT_COLOR,
    );
  }

}