import 'package:brain_storm_mania/configs/themes/app_colors.dart';
import 'package:brain_storm_mania/configs/themes/app_icons.dart';
import 'package:brain_storm_mania/configs/themes/custom_text_styles.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/controllers/questions/quesion_paper_controller.dart';
import 'package:brain_storm_mania/controllers/zoom_drawer_controller.dart';
import 'package:brain_storm_mania/widgets/app_circle_button.dart';
import 'package:brain_storm_mania/widgets/content_area.dart';
import 'package:brain_storm_mania/widgets/question_paper_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

class HomeScreen extends GetView<CustomZoomDrawerController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<CustomZoomDrawerController>(
        builder: (_){
          return ZoomDrawer(
            controller: _.zoomDrawerController,
            borderRadius: 50.0,
            showShadow: true,
            angle: 0,
            style: DrawerStyle.defaultStyle,
            menuBackgroundColor: Colors.white.withOpacity(0.5),
            slideWidth: Get.width * 0.6,
            menuScreen:Text("Hi There"),
            mainScreen: Container(
              decoration: BoxDecoration(
                gradient: mainGradient(),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           AppCircleButton(
                            onTap:()=> controller.toggleDrawer(),
                            child: const Icon(
                              AppIcons.menuLeft,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(AppIcons.peace),
                                Text(
                                  "Hi Amigo",
                                  style:
                                  detailText.copyWith(color: onSurfaceTextColor),
                                )
                              ],
                            ),
                          ),
                          Text(
                            "What do you want to learn today?",
                            style: headerText,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(() => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              itemBuilder: (BuildContext context, int index) {
                                return QuestionPaperCard(
                                  questionPaperModel:
                                  _questionPaperController.papers[index],
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              },
                              itemCount: _questionPaperController.papers.length)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
