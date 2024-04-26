
import '../../../../core/utils/errors/exeptions.dart';

enum QuizDifficulty {
  easy("Easy", "easy"),
  medium("Medium", "medium"),
  hard("Hard", "hard");

  const QuizDifficulty(
    this.name,
    this.value,
  );

  /// Used in the UI
  final String name;

  /// Used in the api call
  final String value;

  factory QuizDifficulty.fromValue(String value) {
    for (final difficulty in values) {
      if (difficulty.value == value) {
        return difficulty;
      }
    }

    throw NoEnumFieldFoundException('Unknown difficulty: $value');
  }
}
