import 'package:brain_storm_mania/configs/themes/app_colors.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/controllers/zoom_drawer_controller.dart';
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
                    )),
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.3),
                  child: Column(
                    children: [
                      Obx(() => controller.user.value != null
                          ? Text(
                              controller.user.value!.displayName ?? "",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w900, fontSize: 18),
                            )
                          : const SizedBox()),
                      const Spacer(
                        flex: 1,
                      ),
                      _DrawerButton(
                          icon: Icons.web,
                          label: "Website",
                          onPressed: () => controller.launchWebsite()),
                      _DrawerButton(
                          icon: Icons.facebook,
                          label: "Website",
                          onPressed: () => controller.launchWebsite()),
                      Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: _DrawerButton(
                            icon: Icons.email,
                            label: "Email",
                            onPressed: () => controller.sendEmail()),
                      ),
                      const Spacer(
                        flex: 4,
                      ),
                      _DrawerButton(
                          icon: Icons.logout,
                          label: "Sign Out",
                          onPressed: () => controller.signOut()),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class _DrawerButton extends StatelessWidget {
  const _DrawerButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed})
      : super(key: key);

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed, icon: Icon(icon, size: 15), label: Text(label));
  }
}
