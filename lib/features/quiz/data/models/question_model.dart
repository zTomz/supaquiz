import '../../../../core/utils/functions/decode_string.dart';
import '../enums/quiz_categories.dart';
import '../enums/quiz_difficulty.dart';
import '../enums/quiz_type.dart';

class QuestionModel {
  final QuizType type;
  final QuizDifficulty difficulty;
  final QuizCategory category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  List<String>? answers;

  QuestionModel({
    required this.type,
    required this.difficulty,
    required this.category,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
  });

  /// Use this when loading data from open trivia api
  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      type: QuizType.fromValue(
        decodeString(map['type'] as String),
      ),
      difficulty: QuizDifficulty.fromValue(
        decodeString(map['difficulty'] as String),
      ),
      category: QuizCategory.fromValue(
        decodeString(map['category'] as String),
      ),
      question: decodeString(map['question'] as String),
      correctAnswer: decodeString(map['correct_answer'] as String),
      incorrectAnswers: List<String>.from(
        (map['incorrect_answers'] as List).map(
          (e) => decodeString(e as String),
        ),
      ),
    );
  }

  /// Use this when loading data from supabase database
  factory QuestionModel.fromJson(Map<String, dynamic> source) {
    return QuestionModel(
      type: QuizType.fromValue(source['type'] as String),
      difficulty: QuizDifficulty.fromValue(source['difficulty'] as String),
      category: QuizCategory.fromId(source['category'] as String),
      question: source['question'] as String,
      correctAnswer: source['correct_answer'] as String,
      incorrectAnswers: List<String>.from(
        (source['incorrect_answers'] as List).map(
          (x) => x as String,
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.value,
      'difficulty': difficulty.value,
      'category': category.value,
      'question': question,
      'correct_answer': correctAnswer,
      'incorrect_answers': incorrectAnswers,
    };
  }

  void generateAnswers() {
    if (answers != null) {
      return;
    }

    // If it is a true / false question, do not shuffle
    if (incorrectAnswers.length + 1 <= 2) {
      answers = [
        "(A) True",
        "(B) False",
      ];
      return;
    }

    final List<String> letters = [
      'A',
      'B',
      'C',
      'D',
    ];

    answers = [
      ...incorrectAnswers,
      correctAnswer,
    ]..shuffle();

    for (int i = 0; i < answers!.length; i++) {
      answers![i] = '(${letters[i]}) ${answers![i]}';
    }
  }
}
