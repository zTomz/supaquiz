// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../quiz/data/models/quiz_model.dart';

class PublicQuizModel {
  final QuizModel quiz;
  final String name;
  final int totalPoints;
  final int correct;
  final int incorrect;
  final int skipped;

  PublicQuizModel({
    required this.quiz,
    required this.name,
    required this.totalPoints,
    required this.correct,
    required this.incorrect,
    required this.skipped,
  });

  factory PublicQuizModel.fromMap(Map<String, dynamic> map) {
    return PublicQuizModel(
      quiz: QuizModel.fromJson({
        'questions': map['questions'] as List,
      }),
      name: (map['name'] as String?) ?? "",
      totalPoints: (map['totalPoints'] as int?) ?? -1,
      correct: (map['correct'] as int?) ?? -1,
      incorrect: (map['incorrect'] as int?) ?? -1,
      skipped: (map['skipped'] as int?) ?? -1,
    );
  }

  factory PublicQuizModel.fromJson(String source) => PublicQuizModel.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );

  @override
  String toString() {
    return 'PublicQuizModel(quiz: $quiz, name: $name, totalPoints: $totalPoints, correct: $correct, incorrect: $incorrect, skipped: $skipped)';
  }
}
