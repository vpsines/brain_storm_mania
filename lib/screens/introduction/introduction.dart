import 'package:brain_storm_mania/widgets/app_circle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../configs/themes/app_colors.dart';

class AppIntroductionScreen extends StatelessWidget {
  const AppIntroductionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(decoration: BoxDecoration(gradient: mainGradient(context)),
        alignment: Alignment.center,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width * 0.2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star,size: 65),
              SizedBox(height: 40,),
              const Text("Welcome to Brain Mania",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18,color: onSurfaceTextColor,fontWeight: FontWeight.bold),),
              SizedBox(height: 40,),
              AppCircleButton(onTap: ()=> null,
                child: const Icon(Icons.arrow_forward, size: 35,),)
            ],
          ),
        ),
      ),
    );
  }
}
