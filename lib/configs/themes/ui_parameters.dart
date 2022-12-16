import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UIParameters{

  // returns true if theme is dark mode
  static bool isDarkMode(BuildContext context){
    return Theme.of(context).brightness == Brightness.dark;
  }
}