
import '../../../../core/utils/errors/exeptions.dart';

enum QuizType {
  trueFalse('True / False', 'boolean'),
  multipleChoice('Multiple Choice', 'multiple');

  const QuizType(
    this.name,
    this.value,
  );

  /// Used in the UI
  final String name;

  /// Used in the api call
  final String value;

  factory QuizType.fromValue(String value) {
    for (final type in values) {
      if (type.value == value) {
        return type;
      }
    }

    throw NoEnumFieldFoundException('Unknown type: $value');
  }
}


