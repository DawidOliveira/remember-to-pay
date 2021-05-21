import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remember_to_pay/app/core/app_colors.dart';

class AppTheme {
  static ThemeData themeLight = ThemeData.light().copyWith(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline6: GoogleFonts.poppins(
        fontSize: 26,
        color: AppColors.DARK_COLOR,
      ),
      headline4: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: AppColors.DARK_COLOR,
        fontSize: 18,
      ),
      overline: GoogleFonts.poppins(
        color: AppColors.DARK_COLOR,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      subtitle1: GoogleFonts.poppins(
        color: AppColors.DARK_COLOR,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      subtitle2: GoogleFonts.poppins(
        color: AppColors.GREY,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: GoogleFonts.poppins(
        color: AppColors.DARK_COLOR,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      caption: GoogleFonts.poppins(
        color: AppColors.GREY,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    primaryColor: Colors.blue,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: AppColors.DARK_COLOR,
      ),
    ),
    scaffoldBackgroundColor: AppColors.WHITE,
  );

  static ThemeData themeDark = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      headline6: GoogleFonts.poppins(
        fontSize: 26,
        color: AppColors.WHITE,
      ),
      headline5: GoogleFonts.poppins(
        color: AppColors.WHITE,
      ),
      overline: GoogleFonts.poppins(
        color: AppColors.WHITE,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      headline4: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: AppColors.WHITE,
        fontSize: 18,
      ),
      subtitle1: GoogleFonts.poppins(
        color: AppColors.WHITE,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      subtitle2: GoogleFonts.poppins(
        color: AppColors.GREY,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodyText2: GoogleFonts.poppins(
        color: AppColors.DARK_COLOR,
        fontSize: 18,
        fontWeight: FontWeight.w300,
      ),
      caption: GoogleFonts.poppins(
        color: AppColors.GREY,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: AppColors.DARK_COLOR,
  );
}
