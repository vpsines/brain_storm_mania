class Answers {
  String? identifier;
  String? answer;

  Answers({
    this.identifier,
    this.answer,
  });

  Answers.fromJson(Map<String, dynamic> json) {
    identifier = json['identifier'];
    answer = json['Answer'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['identifier'] = identifier;
    map['Answer'] = answer;
    return map;
  }
}
