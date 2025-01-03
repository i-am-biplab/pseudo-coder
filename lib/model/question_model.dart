import 'dart:convert';

class Question {
  final String question;

  Question({required this.question});

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json['question'],
      );
}

class QuestionData {
  final List<Question> questions;

  QuestionData({required this.questions});

  factory QuestionData.fromJson(String str) =>
      QuestionData.fromMap(json.decode(str));

  factory QuestionData.fromMap(Map<String, dynamic> json) => QuestionData(
        questions: List<Question>.from(
            json['questions'].map((x) => Question.fromJson(x))),
      );
}
