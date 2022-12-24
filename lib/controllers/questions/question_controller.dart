import 'dart:async';

import 'package:brain_storm_mania/controllers/questions/quesion_paper_controller.dart';
import 'package:brain_storm_mania/firebase_ref/loading_status.dart';
import 'package:brain_storm_mania/firebase_ref/references.dart';
import 'package:brain_storm_mania/models/answers.dart';
import 'package:brain_storm_mania/models/question_paper_model.dart';
import 'package:brain_storm_mania/models/questions.dart';
import 'package:brain_storm_mania/screens/home/home_screen.dart';
import 'package:brain_storm_mania/screens/question/result_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController {
  late QuestionPaperModel questionPaperModel;
  late List<Questions> allQuestions = <Questions>[];
  final loadingStatus = LoadingStatus.loading.obs;

  Rxn<Questions> currentQuestion = Rxn<Questions>();

  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value == 0;
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  // Timer
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00.00'.obs;

  @override
  void onReady() {
    final questionPaper = Get.arguments as QuestionPaperModel;
    loadData(questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionPaperModel questionPaper) async {
    questionPaperModel = questionPaper;
    try {
      loadingStatus.value = LoadingStatus.loading;
      // get questions for question model
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRef
              .doc(questionPaper.id)
              .collection("questions")
              .get();
      final questions = questionQuery.docs
          .map((snapshot) => Questions.fromSnapshot(snapshot))
          .toList();

      questionPaper.questions = questions;

      // get answer docs for each questions
      for (Questions question in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answerQuery =
            await questionPaperRef
                .doc(questionPaper.id)
                .collection("questions")
                .doc(question.id)
                .collection("answers")
                .get();

        final answers = answerQuery.docs
            .map((snapshot) => Answers.fromSnapshot(snapshot))
            .toList();
        question.answers = answers;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }

    if (questionPaper.questions != null &&
        questionPaper.questions!.isNotEmpty) {
      allQuestions.assignAll(questionPaper.questions!);
      currentQuestion.value = questionPaper.questions![0];
      _startTimer(questionPaper.timeSeconds);
      loadingStatus.value = LoadingStatus.completed;
    } else {
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list','answer_review_list']);
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) {
      return;
    } else {
      questionIndex.value++;
      currentQuestion.value = allQuestions[questionIndex.value];
    }
  }

  void previousQuestion() {
    if (questionIndex.value <= 0) {
      return;
    } else {
      questionIndex.value--;
      currentQuestion.value = allQuestions[questionIndex.value];
    }
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int sec = remainingSeconds % 60;
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${sec.toString().padLeft(2, "0")}";
        remainingSeconds--;
      }
    });
  }

  String get completedTest {
    final answered = allQuestions
        .where((element) => element.selectedAnswer != null)
        .toList()
        .length;
    return "$answered out of ${allQuestions.length} answered";
  }

  // jumps to question at respective index
  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    }
  }

  void completeQuiz() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  // method to restart quiz
  void tryAgain() {
    Get.find<QuestionPaperController>()
        .navigateToQuestions(model: questionPaperModel, tryAgain: true);
  }

  // navigate to home
  void navigateToHomeScreen() {
    _timer!.cancel();
    Get.offNamedUntil(HomeScreen.routeName, (route) => false);
  }
}
