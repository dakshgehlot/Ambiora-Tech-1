import 'dart:convert';
import 'package:flutter/services.dart';

class Question {
  final String question;
  final String statement;
  final List<String> answers;
  final int correctAnswer;

  Question(this.question, this.statement, this.answers, this.correctAnswer);

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      json['question'],
      json['statement'],
      List<String>.from(json['answers']),
      json['correctAnswer'],
    );
  }
}

Future<void> readquestionJson() async {
  questions = [];
  final String response =
      await rootBundle.loadString('lib/questions/questions.json');
  final data = await json.decode(response);
  for (var i = 0; i < data["questions"].length; i++) {
    questions.add(Question.fromJson(data["questions"][i]));
  }
}

Future<void> readfunquestionJson() async {
  final String response =
      await rootBundle.loadString('lib/questions/fun_questions.json');
  final data = await json.decode(response);
  for (var i = 0; i < data["questions"].length; i++) {
    questions.add(Question.fromJson(data["questions"][i]));
  }
}

List<Question> questions = [];
