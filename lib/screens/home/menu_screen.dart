import 'package:brain_storm_mania/configs/themes/app_colors.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/controllers/zoom_drawer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends GetView<CustomZoomDrawerController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIParameters.mobileScreenPadding,
      width: double.minPositive,
      decoration: BoxDecoration(gradient: mainGradient()),
      child: Theme(
          data: ThemeData(
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(primary: onSurfaceTextColor))),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    right: 0,
                    child: BackButton(
                      color: Colors.white,
                      onPressed: () {
                        controller.toggleDrawer();
                      },
                    ))
              ],
            ),
          )),
    );
  }
}
