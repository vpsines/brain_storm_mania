import 'package:cloud_firestore/cloud_firestore.dart';

import 'questions.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  int questionCount;
  List<Questions>? questions;

  QuestionPaperModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    required this.questionCount,
    this.questions,
  });

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['Description'],
        timeSeconds = json['time_seconds'],
        questionCount = 0,
        questions = (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();

  QuestionPaperModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['image_url'],
        description = json['Description'],
        timeSeconds = json['time_seconds'],
        questionCount =json['questions_count'] as int,
        questions = [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image_url'] = imageUrl;
    map['Description'] = description;
    map['time_seconds'] = timeSeconds;
    map['question_count'] = questionCount;
    if (questions != null) {
      map['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
