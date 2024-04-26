import '../enums/quiz_categories.dart';
import '../enums/quiz_difficulty.dart';
import '../enums/quiz_type.dart';

class QuizParams {
  /// The number of questions to retrieve
  /// Must be between 1 and 50, default is 10
  final int number;

  /// The category of the questions to retrieve
  final QuizCategory? category;

  /// The difficulty of the questions to retrieve
  final QuizDifficulty? difficulty;

  /// The type of the questions to retrieve
  final QuizType? type;

  /// The session token
  final String? sessionToken;

  const QuizParams({
    this.number = 10,
    this.category,
    this.difficulty,
    this.type,
    this.sessionToken,
  })  : assert(number >= 1, 'Number must be greater than or equal to 1'),
        assert(number <= 50, 'Number must be less than or equal to 50');

  Map<String, dynamic> toMap() {
    Map<String, dynamic> paramMap = {
      'amount': number,
    };

    if (category != null) {
      paramMap['category'] = category!.value;
    }

    if (difficulty != null) {
      paramMap['difficulty'] = difficulty!.value;
    }

    if (type != null) {
      paramMap['type'] = type!.value;
    }

    if (sessionToken != null) {
      paramMap['token'] = sessionToken;
    }

    return paramMap;
  }
}
