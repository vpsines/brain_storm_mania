import 'dart:convert';

import 'package:brain_storm_mania/firebase_ref/loading_status.dart';
import 'package:brain_storm_mania/firebase_ref/references.dart';
import 'package:brain_storm_mania/models/question_paper_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final loadingStatus = LoadingStatus.loading.obs;

  Future<void> uploadData() async {
    loadingStatus.value = LoadingStatus.loading; // 0

    if (kDebugMode) {
      print("Data is uploading....");
    }
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");
    final Map<String, dynamic> manifestMap = jsonDecode(manifestContent);
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/papers") && path.contains(".json"))
        .toList();
    print(papersInAssets);

    List<QuestionPaperModel> questionPapers = [];
    for (var paper in papersInAssets) {
      String stringPaperContent = await rootBundle.loadString(paper);
      questionPapers
          .add(QuestionPaperModel.fromJson(jsonDecode(stringPaperContent)));
    }
    print("Items no : ${questionPapers.length}");

    var batch = firestore.batch();

    // add question papers to firebase
    for (var paper in questionPapers) {
      batch.set(questionPaperRef.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count": paper.questions != null ? paper.questions!.length : 0
      });

      // add questions
      for(var question in paper.questions!){
        final questionPath = questionRef(paperId: paper.id, questionId: question.id);
        batch.set(questionPath,{
          "question":question.question,
          "correct_answer":question.correctAnswer
        });

        // add answers of questions
        for(var answer in question.answers){
          batch.set(questionPath.collection("answers").doc(answer.identifier),{
            "answer":answer.answer,
            "identifier":answer.identifier
          });
        }
      }
    }

    await batch.commit();
    loadingStatus.value = LoadingStatus.completed; // 1
  }
}
