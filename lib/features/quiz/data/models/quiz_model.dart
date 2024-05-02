import 'question_model.dart';

class QuizModel {
  final List<QuestionModel> questions;

  QuizModel({
    required this.questions,
  });

  /// Use this when loading data from open trivia api
  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      questions: List<QuestionModel>.from(
        (map['results'] as List<dynamic>).map<QuestionModel>(
          (x) => QuestionModel.fromMap(x),
        ),
      ),
    );
  }

  /// Use this when loading data from supabase database
  factory QuizModel.fromJson(Map<String, dynamic> source) {
    return QuizModel(
      questions: List<QuestionModel>.from(
        (source['questions'] as List<dynamic>).map<QuestionModel>(
          (x) => QuestionModel.fromJson(x),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }
}
