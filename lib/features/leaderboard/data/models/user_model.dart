import 'dart:convert';

import 'public_quiz_model.dart';

class UserModel {
  /// The id of the user
  final String id;

  /// The name of the user
  final String name;

  /// When the user first uploaded a quiz
  final DateTime createdAt;

  /// The quizzes that the user uploaded
  final List<PublicQuizModel> quizzes;

  /// The points the user has
  final int points;

  UserModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.quizzes,
    required this.points,
  });

  /// Use this when loading data from supabase
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['user_id'] as String,
      name: map['username'] as String,
      createdAt: DateTime.parse(map['created_at'] as String),
      quizzes: List<PublicQuizModel>.from(
        (map['quizzes'] as List<dynamic>).map<PublicQuizModel>(
          (x) => PublicQuizModel.fromJson(x as String),
        ),
      ),
      points: map['points'] as int,
    );
  }

  factory UserModel.fromJson(String source) {
    final sourceMap = json.decode(source) as Map<String, dynamic>;

    return UserModel(
      id: sourceMap['user_id'] as String,
      name: sourceMap['username'] as String,
      createdAt: DateTime.parse(sourceMap['created_at'] as String),
      quizzes: List<PublicQuizModel>.from(
        (sourceMap['quizzes'] as List<dynamic>).map<PublicQuizModel>(
          (x) => PublicQuizModel.fromJson(x as String),
        ),
      ),
      points: sourceMap['points'] as int,
    );
  }

  @override
  String toString() =>
      'UserModel(id: $id, name: $name, createdAt: $createdAt, quizzes: $quizzes, points: $points)';
}
