import 'package:cloud_firestore/cloud_firestore.dart';

import 'answers.dart';

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions({
    required this.id,
    required this.question,
    required this.answers,
    this.correctAnswer,
  });

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers = (json['answers'] as List)
            .map((dynamic e) => Answers.fromJson(e as Map<String, dynamic>))
            .toList(),
        correctAnswer = json['correct_answer'];

  Questions.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question'] = question;
    if (answers != null) {
      map['answers'] = answers.map((v) => v.toJson()).toList();
    }
    map['correct_answer'] = correctAnswer;
    return map;
  }
}
