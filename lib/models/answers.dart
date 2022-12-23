import 'package:cloud_firestore/cloud_firestore.dart';

class Answers {
  String? identifier;
  String? answer;

  Answers({
    this.identifier,
    this.answer,
  });

  Answers.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    answer = json['answer'];
  }

  Answers.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    identifier = snapshot['identifier'] as String?;
    answer = snapshot['answer'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identifier'] = identifier;
    map['answer'] = answer;
    return map;
  }
}
