import 'package:brain_storm_mania/configs/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin SubThemeData{

  TextTheme getTextThemes(){
    return GoogleFonts.quicksandTextTheme(
      const TextTheme(
        bodyText1: TextStyle(fontWeight: FontWeight.w400),
        bodyText2: TextStyle(fontWeight: FontWeight.w400)
      )
    );
  }

  IconThemeData getIconThemeData(){
    return const IconThemeData(color: onSurfaceTextColor,size: 16);
  }
}