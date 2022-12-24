import 'package:brain_storm_mania/configs/themes/custom_text_styles.dart';
import 'package:brain_storm_mania/controllers/questions/question_controller.dart';
import 'package:brain_storm_mania/screens/question/result_screen.dart';
import 'package:brain_storm_mania/widgets/base/background_decoration.dart';
import 'package:brain_storm_mania/widgets/base/custom_app_bar.dart';
import 'package:brain_storm_mania/widgets/content_area.dart';
import 'package:brain_storm_mania/widgets/questions/answer_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnswerCheckScreen extends GetView<QuestionController> {
  static const String routeName = "/answercheckscreen";

  const AnswerCheckScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(() => Text(
              'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
              style: appBarTextStyle,
            )),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackgroundDecoration(
          child: Obx(() => Column(
                children: [
                  Expanded(
                      child: ContentArea(
                          child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Text(controller.currentQuestion.value!.question),
                        GetBuilder(
                            id: 'answer_review_list',
                            builder: (_) {
                              return ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, int index) {
                                    final answer = controller
                                        .currentQuestion.value!.answers[index];
                                    final selectedAnswer = controller
                                        .currentQuestion.value!.selectedAnswer;
                                    final correctAnswer = controller
                                        .currentQuestion.value!.correctAnswer;
                                    final String answerText =
                                        '${answer.identifier}. ${answer.answer}';
                                    if (correctAnswer == selectedAnswer &&
                                        answer.identifier == selectedAnswer) {
                                      // selected answer is correct
                                      return CorrectAnswer(answer: answerText);
                                    } else if (selectedAnswer == null) {
                                      // user has not selected user
                                      return NotAnswered(answer: answerText);
                                    } else if (correctAnswer !=
                                            selectedAnswer &&
                                        answer.identifier == selectedAnswer) {
                                      // selected answer is wrong
                                      return WrongAnswer(answer: answerText);
                                    } else if (correctAnswer ==
                                        answer.identifier) {
                                      // correct answer
                                      return CorrectAnswer(answer: answerText);
                                    }
                                    return AnswerCard(
                                      answer: answerText,
                                      onTap: () {},
                                      isSelected: false,
                                    );
                                  },
                                  separatorBuilder: (_, int index) {
                                    return const SizedBox(
                                      height: 10,
                                    );
                                  },
                                  itemCount: controller
                                      .currentQuestion.value!.answers.length);
                            })
                      ],
                    ),
                  )))
                ],
              ))),
    );
  }
}
