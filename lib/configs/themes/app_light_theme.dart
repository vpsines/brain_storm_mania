
import 'package:brain_storm_mania/configs/themes/sub_theme_data_mixin.dart';
import 'package:flutter/material.dart';

const Color primaryLightColorLight = Color(0xFF3ac3cb);
const Color primaryColorLight = Color(0XFFf85187);

const Color mainTextColorLight = Color.fromARGB(255, 40, 40, 40);

class LightTheme with SubThemeData{
  buildLightTheme(){
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
      textTheme: getTextThemes().apply(bodyColor: mainTextColorLight,displayColor: mainTextColorLight),
      iconTheme: getIconThemeData()
    );
  }
}