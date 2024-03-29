import 'package:brain_storm_mania/configs/themes/app_icons.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/screens/question/test_overview_screen.dart';
import 'package:brain_storm_mania/widgets/app_circle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/custom_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  const CustomAppBar(
      {Key? key,
      this.title = '',
      this.titleWidget,
      this.leading,
      this.showActionIcon = false,
      this.onMenuActionTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding, vertical: mobileScreenPadding),
      child: Stack(
        children: [
          Positioned.fill(
              child: Center(
            child: titleWidget ??
                Text(
                  title,
                  style: appBarTextStyle,
                ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: const BackButton(),
                  ),
              if (showActionIcon)
                Transform.translate(
                  offset: const Offset(10, 0),
                  child: AppCircleButton(
                    onTap: onMenuActionTap ??
                        () => Get.toNamed(TestOverviewScreen.routeName),
                    child: const Icon(AppIcons.menu),
                  ),
                )
            ],
          )
        ],
      ),
    ));
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 80);
}
