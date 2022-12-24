import 'package:brain_storm_mania/configs/themes/custom_text_styles.dart';
import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/controllers/questions/question_controller.dart';
import 'package:brain_storm_mania/controllers/questions/question_controller_extension.dart';
import 'package:brain_storm_mania/screens/question/answer_check_screen.dart';
import 'package:brain_storm_mania/widgets/base/background_decoration.dart';
import 'package:brain_storm_mania/widgets/base/custom_app_bar.dart';
import 'package:brain_storm_mania/widgets/base/main_button.dart';
import 'package:brain_storm_mania/widgets/content_area.dart';
import 'package:brain_storm_mania/widgets/questions/answer_card_widget.dart';
import 'package:brain_storm_mania/widgets/questions/question_number_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ResultScreen extends GetView<QuestionController> {
  static const String routeName = "/resultscreen";
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BackgroundDecoration(
          child: Column(
        children: [
          CustomAppBar(
            leading: const SizedBox(
              height: 80,
            ),
            title: controller.correctAnsweredQuestions,
          ),
          Expanded(
              child: ContentArea(
            child: Column(
              children: [
                SvgPicture.asset("assets/images/bulb.svg"),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 5),
                  child: Text('Congratulations',
                      style: headerText.copyWith(color: _textColor)),
                ),
                Text('You have ${controller.points} points',
                    style: TextStyle(color: _textColor)),
                const SizedBox(
                  height: 25,
                ),
                Text('Tap below question numbers to view correct answers',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _textColor)),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                    child: GridView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Get.width ~/ 75,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (_, index) {
                    final _question = controller.allQuestions[index];
                    AnswerStatus _status = AnswerStatus.notanswered;
                    final _selectedAnswer = _question.selectedAnswer;
                    final _correctAnswer = _question.correctAnswer;
                    if (_selectedAnswer == _correctAnswer) {
                      _status = AnswerStatus.correct;
                    } else if (_question.selectedAnswer == null) {
                      _status = AnswerStatus.wrong;
                    } else {
                      _status = AnswerStatus.wrong;
                    }
                    return QuestionNumberCard(
                        index: index + 1,
                        status: _status,
                        onTap: () {
                          controller.jumpToQuestion(index, isGoBack: false);
                          Get.toNamed(AnswerCheckScreen.routeName);
                        });
                  },
                  itemCount: controller.allQuestions.length,
                )),
                ColoredBox(color: Theme.of(context).scaffoldBackgroundColor,
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: Row(
                    children: [
                      Expanded(
                        child: MainButton(onTap: (){
                          controller.tryAgain();
                        },color: Colors.blueGrey,
                        title: "Try Again",),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: MainButton(onTap: (){
                            controller.saveQuizResults();
                        },color: Colors.blueGrey,
                          title: "Go Home",),
                      )
                    ],
                  ),
                ),)
              ],
            ),
          ))
        ],
      )),
    );
  }
}
