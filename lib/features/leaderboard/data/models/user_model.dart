import 'dart:convert';

import '../../../quiz/data/models/quiz_model.dart';

class UserModel {
  /// The id of the user
  final String id;

  /// The name of the user
  final String name;

  /// When the user first uploaded a quiz
  final DateTime createdAt;

  /// The quizzes that the user uploaded
  final List<QuizModel> quizzes;

  /// The points the user has
  final int points;

  UserModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.quizzes,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_id': id,
      'username': name,
      'created_at': createdAt.millisecondsSinceEpoch,
      'quizzes': quizzes.map((x) => x.toMap()).toList(),
      'points': points,
    };
  }

  /// Use this when loading data from open trivia api
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['user_id'] as String,
      name: map['username'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      quizzes: List<QuizModel>.from(
        (map['quizzes'] as List).map<QuizModel>(
          (x) => QuizModel.fromMap(jsonDecode(x as String)),
        ),
      ),
      points: map['points'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  /// Use this when loading data from supabase
  factory UserModel.fromJson(Map<String, dynamic> source) {
    return UserModel(
      id: source['user_id'] as String,
      name: source['username'] as String,
      createdAt: DateTime.parse(source['created_at'] as String),
      quizzes: List<QuizModel>.from(
        (source['quizzes'] as List).map<QuizModel>(
          (x) => QuizModel.fromJson(jsonDecode(x as String)),
        ),
      ),
      points: source['points'] as int,
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, createdAt: $createdAt, quizzes: $quizzes, points: $points)';
}
