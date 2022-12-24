
import 'package:brain_storm_mania/configs/themes/app_colors.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

TextStyle cardTitles(context) => TextStyle(
    color: UIParameters.isDarkMode() ? Theme.of(context).textTheme.bodyText1!.color :
    Theme.of(context).primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold
);

const detailText = TextStyle(
    fontSize: 12,
);
const headerText = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: onSurfaceTextColor
);

const questionTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w800,
);

const appBarTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: onSurfaceTextColor
);

TextStyle countDownTimerTextStyle = TextStyle(
    letterSpacing: 2,
    color: UIParameters.isDarkMode() ? Theme.of(Get.context!).textTheme.bodyText1!.color :
        Theme.of(Get.context!).primaryColor
);