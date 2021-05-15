import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remember_to_pay/app/core/app_colors.dart';

class AppTextStyle {
  // ignore: non_constant_identifier_names
  static TextStyle HEADER = GoogleFonts.poppins(
    color: AppColors.DARK_COLOR,
    fontSize: 26,
  );

  // ignore: non_constant_identifier_names
  static TextStyle BODY_TEXT = GoogleFonts.poppins(
    color: AppColors.WHITE,
    fontSize: 18,
    fontWeight: FontWeight.w300,
  );

  // ignore: non_constant_identifier_names
  static TextStyle SUBTITLE = GoogleFonts.poppins(
    color: AppColors.GREY,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
