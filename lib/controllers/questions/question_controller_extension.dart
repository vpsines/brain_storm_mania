import 'package:brain_storm_mania/controllers/auth_controller.dart';
import 'package:brain_storm_mania/controllers/questions/question_controller.dart';
import 'package:brain_storm_mania/firebase_ref/references.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

extension QuestionControllerExtension on QuestionController {
  // gets count of correct answers
  int get correctQuestionsCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  // gets correct answer count as string
  String get correctAnsweredQuestions {
    return '$correctQuestionsCount out of ${allQuestions.length} are correct';
  }

  // get points for the quiz
  String get points {
    var points = (correctQuestionsCount / allQuestions.length) *
        100 *
        (questionPaperModel.timeSeconds - remainingSeconds) /
        questionPaperModel.timeSeconds *
        100;
    return points.toStringAsFixed(2);
  }

  // saves quiz results
  Future<void> saveQuizResults() async {
    var batch = firestore.batch();
    User? user = Get.find<AuthController>().getCurrentUser();
    if (user != null) {
      batch.set(
          userRef
              .doc(user.email)
              .collection('scores')
              .doc(questionPaperModel.id),
          {
            "points": points,
            "correct_answers": '$correctQuestionsCount/${allQuestions.length}',
            "question_id": questionPaperModel.id,
            "time": questionPaperModel.timeSeconds - remainingSeconds
          });
      batch.commit();
      navigateToHomeScreen();
    }
  }
}
