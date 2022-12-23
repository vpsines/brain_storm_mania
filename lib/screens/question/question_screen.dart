import 'package:brain_storm_mania/configs/themes/custom_text_styles.dart';
import 'package:brain_storm_mania/controllers/questions/question_controller.dart';
import 'package:brain_storm_mania/firebase_ref/loading_status.dart';
import 'package:brain_storm_mania/widgets/base/background_decoration.dart';
import 'package:brain_storm_mania/widgets/base/question_place_holder.dart';
import 'package:brain_storm_mania/widgets/content_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({Key? key}) : super(key: key);
  static const String routeName = "/questionsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundDecoration(
          child: Obx(() => Column(
                children: [
                  Expanded(
                      child: ContentArea(
                          child: (controller.loadingStatus.value ==
                                  LoadingStatus.loading)
                              ? const QuestionScreenPlaceHolder()
                              : (controller.loadingStatus.value ==
                                      LoadingStatus.completed)
                                  ? SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Text(controller
                                              .currentQuestion.value!.question,
                                          style: questionTextStyle,)
                                        ],
                                      ),
                                    )
                                  : Container()))
                ],
              ))),
    );
  }
}
