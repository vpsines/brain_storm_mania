import 'package:brain_storm_mania/configs/themes/app_colors.dart';
import 'package:brain_storm_mania/configs/themes/custom_text_styles.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/controllers/questions/question_controller.dart';
import 'package:brain_storm_mania/firebase_ref/loading_status.dart';
import 'package:brain_storm_mania/screens/question/test_overview_screen.dart';
import 'package:brain_storm_mania/widgets/base/background_decoration.dart';
import 'package:brain_storm_mania/widgets/base/custom_app_bar.dart';
import 'package:brain_storm_mania/widgets/base/main_button.dart';
import 'package:brain_storm_mania/widgets/base/question_place_holder.dart';
import 'package:brain_storm_mania/widgets/content_area.dart';
import 'package:brain_storm_mania/widgets/questions/answer_card_widget.dart';
import 'package:brain_storm_mania/widgets/questions/count_down_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionScreen extends GetView<QuestionController> {
  const QuestionScreen({Key? key}) : super(key: key);
  static const String routeName = "/questionsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const ShapeDecoration(
              shape: StadiumBorder(
                  side: BorderSide(color: onSurfaceTextColor, width: 2))),
          child: Obx(() => CountDownTimer(
                time: controller.time.value,
                color: onSurfaceTextColor,
              )),
        ),
        titleWidget: Obx(() => Text(
              "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}",
              style: appBarTextStyle,
            )),
        showActionIcon: true,
      ),
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
                                      padding: const EdgeInsets.only(top: 25),
                                      child: Column(
                                        children: [
                                          Text(
                                            controller.currentQuestion.value!
                                                .question,
                                            style: questionTextStyle,
                                          ),
                                          GetBuilder<QuestionController>(
                                              id: 'answers_list',
                                              builder: (context) {
                                                return ListView.separated(
                                                    shrinkWrap: true,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 25),
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int index) {
                                                      final answer = controller
                                                          .currentQuestion
                                                          .value!
                                                          .answers[index];
                                                      return AnswerCard(
                                                        answer:
                                                            "${answer.identifier}. ${answer.answer}",
                                                        onTap: () {
                                                          controller
                                                              .selectedAnswer(
                                                                  answer
                                                                      .identifier);
                                                        },
                                                        isSelected: answer
                                                                .identifier ==
                                                            controller
                                                                .currentQuestion
                                                                .value!
                                                                .selectedAnswer,
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (BuildContext context,
                                                                int index) =>
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                    itemCount: controller
                                                        .currentQuestion
                                                        .value!
                                                        .answers
                                                        .length);
                                              }),
                                        ],
                                      ),
                                    )
                                  : Container())),
                  ColoredBox(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Padding(
                      padding: UIParameters.mobileScreenPadding,
                      child: Row(
                        children: [
                          Visibility(
                              visible: !controller.isFirstQuestion,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: SizedBox(
                                  width: 55,
                                  height: 55,
                                  child: MainButton(
                                    onTap: () {
                                      controller.previousQuestion();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Get.isDarkMode
                                          ? onSurfaceTextColor
                                          : Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              )),
                          Expanded(
                            child: Visibility(
                                visible: controller.loadingStatus.value ==
                                    LoadingStatus.completed,
                                child: MainButton(
                                  title: controller.isLastQuestion
                                      ? "Complete"
                                      : "Next",
                                  onTap: () {
                                    controller.isLastQuestion
                                        ? Get.toNamed(
                                            TestOverviewScreen.routeName)
                                        : controller.nextQuestion();
                                  },
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
