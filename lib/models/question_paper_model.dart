import 'questions.dart';

class QuestionPaperModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;

  QuestionPaperModel({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.description,
    required this.timeSeconds,
    this.questions,
  });

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['Description'],
        timeSeconds = json['time_seconds'],
        questions = (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['image_url'] = imageUrl;
    map['Description'] = description;
    map['time_seconds'] = timeSeconds;
    if (questions != null) {
      map['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
