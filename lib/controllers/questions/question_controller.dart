import 'package:brain_storm_mania/firebase_ref/loading_status.dart';
import 'package:brain_storm_mania/firebase_ref/references.dart';
import 'package:brain_storm_mania/models/answers.dart';
import 'package:brain_storm_mania/models/question_paper_model.dart';
import 'package:brain_storm_mania/models/questions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class QuestionController extends GetxController{

  late QuestionPaperModel questionPaperModel;
  late List<Questions> allQuestions = <Questions>[];
  final loadingStatus = LoadingStatus.loading.obs;

  Rxn<Questions> currentQuestion = Rxn<Questions>();

  @override
  void onReady() {
    final questionPaper  = Get.arguments as QuestionPaperModel;
    loadData(questionPaper);
    super.onReady();
  }

  Future<void> loadData(QuestionPaperModel questionPaper) async{
    questionPaperModel = questionPaper;
    try{

      loadingStatus.value = LoadingStatus.loading;
      // get questions for question model
      final QuerySnapshot<Map<String,dynamic>> questionQuery = await questionPaperRef.doc(questionPaper.id).collection("questions").get();
      final questions = questionQuery.docs.map((snapshot) => Questions.fromSnapshot(snapshot)).toList();

      questionPaper.questions = questions;

      // get answer docs for each questions
      for(Questions question in questionPaper.questions!){
        final QuerySnapshot<Map<String,dynamic>> answerQuery = await questionPaperRef.doc(questionPaper.id)
            .collection("questions")
            .doc(question.id)
            .collection("answers")
            .get();

        final answers = answerQuery.docs.map((snapshot) => Answers.fromSnapshot(snapshot)).toList();
        question.answers = answers;

        if(questionPaper.questions !=null && questionPaper.questions!.isNotEmpty){
          allQuestions.assignAll(questionPaper.questions!);
          currentQuestion.value = questionPaper.questions![0];
         // loadingStatus.value = LoadingStatus.completed;
        }else{
          loadingStatus.value = LoadingStatus.error;
        }
      }
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}