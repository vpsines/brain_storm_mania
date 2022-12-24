import 'package:brain_storm_mania/configs/themes/custom_text_styles.dart';
import 'package:flutter/material.dart';

class CountDownTimer extends StatelessWidget {
  final Color? color;
  final String time;

  const CountDownTimer({Key? key, this.color, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.timer,
          color: color ?? Theme.of(context).primaryColor,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          time,
          style: countDownTimerTextStyle.copyWith(color: color),
        )
      ],
    );
  }
}
