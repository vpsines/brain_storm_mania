import 'package:brain_storm_mania/configs/themes/custom_text_styles.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/controllers/questions/question_controller.dart';
import 'package:brain_storm_mania/widgets/base/background_decoration.dart';
import 'package:brain_storm_mania/widgets/base/custom_app_bar.dart';
import 'package:brain_storm_mania/widgets/base/main_button.dart';
import 'package:brain_storm_mania/widgets/content_area.dart';
import 'package:brain_storm_mania/widgets/questions/answer_card_widget.dart';
import 'package:brain_storm_mania/widgets/questions/count_down_timer.dart';
import 'package:brain_storm_mania/widgets/questions/question_number_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestOverviewScreen extends GetView<QuestionController> {
  static const String routeName = "/testoverview";
  const TestOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: controller.completedTest,
      ),
      body: BackgroundDecoration(
          child: Column(
        children: [
          Expanded(
              child: ContentArea(
            child: Column(
              children: [
                Row(
                  children: [
                    CountDownTimer(
                      color: UIParameters.isDarkMode()
                          ? Theme.of(context).textTheme.bodyText1!.color
                          : Theme.of(context).primaryColor,
                      time: '',
                    ),
                    Obx(() => Text('${controller.time} Remaining',
                        style: countDownTimerTextStyle))
                  ],
                ),
                const SizedBox(height: 20,),
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.allQuestions.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Get.width ~/75,
                        childAspectRatio: 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8
                      ), 
                      itemBuilder: (_,index){
                      AnswerStatus? _answerStatus;
                      if(controller.allQuestions[index].selectedAnswer!= null){
                        _answerStatus = AnswerStatus.answered;
                      }
                      
                      return QuestionNumberCard(
                        index: index+1,
                        status: _answerStatus,
                        onTap: () => controller.jumpToQuestion(index),
                      );
                      }
                  ),
                )
              ],
            ),
          )),
          ColoredBox(color: Theme.of(context).scaffoldBackgroundColor,
          child: Padding(padding: UIParameters.mobileScreenPadding,
          child: MainButton(
            onTap: (){
            controller.completeQuiz();
          },
            title: "Complete",
          ),),)
        ],
      )),
    );
  }
}
