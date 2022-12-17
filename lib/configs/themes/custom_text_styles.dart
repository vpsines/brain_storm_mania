
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

TextStyle cardTitles(context) => TextStyle(
    color: UIParameters.isDarkMode() ? Theme.of(context).textTheme.bodyText1!.color :
    Theme.of(context).primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold
);