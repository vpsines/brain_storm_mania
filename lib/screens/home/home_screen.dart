import 'package:brain_storm_mania/configs/themes/ui_parameters.dart';
import 'package:brain_storm_mania/controllers/questions/quesion_paper_controller.dart';
import 'package:brain_storm_mania/widgets/question_paper_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: Obx(() => ListView.separated(
        padding: UIParameters.mobileScreenPadding,
          itemBuilder: (BuildContext context, int index) {
            return QuestionPaperCard(
              questionPaperModel: _questionPaperController.papers[index],
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 20,
            );
          },
          itemCount: _questionPaperController.papers.length)),
    );
  }
}
