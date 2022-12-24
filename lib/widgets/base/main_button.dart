import 'package:brain_storm_mania/configs/themes/app_colors.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {Key? key,
      this.title = "",
      this.child,
      this.color,
      this.enabled = true,
      required this.onTap})
      : super(key: key);

  final String title;
  final Widget? child;
  final Color? color;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 55,
        child: InkWell(
            onTap: enabled ? onTap : null,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: color ?? Theme.of(context).cardColor,
              ),
              width: double.maxFinite,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: child ??
                    Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: UIParameters.isDarkMode()
                                ? onSurfaceTextColor
                                : Theme.of(context).primaryColor),
                      ),
                    ),
              ),
            )),
      ),
    );
  }
}
