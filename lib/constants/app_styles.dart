import 'package:flutter/material.dart';

import 'package:convergeimmob/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static TextStyle title({
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return GoogleFonts.inter(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: fontSize ?? 16,
      color: AppColors.black,
    );
  }

  static TextStyle smallTitle({
    FontWeight? fontWeight,
    double? fontSize,
    Color? color
  }) {
    return TextStyle(
      fontFamily: 'Oswald',
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: fontSize ?? 12,
      color: color ?? AppColors.black,
    );
  }

  static TextStyle smallTitleWhite({
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(
      fontFamily: 'Oswald',
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: fontSize ?? 12,
      color: AppColors.white,
    );
  }

  static TextStyle placeHolder(FontWeight fontWeight) {
    return TextStyle(
      color: AppColors.white,
      fontSize: 18,
      fontFamily: 'Oswald',
      fontWeight: fontWeight,
    );
  }
}
