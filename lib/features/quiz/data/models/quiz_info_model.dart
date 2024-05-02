class QuizInfoModel {
  /// The time in seconds it took
  final Stopwatch? time;

  /// The name of the quiz
  final String name;

  final int totalPoints;

  final int correct;

  final int incorrect;

  final int skipped;

  final int currentQuestion;

  QuizInfoModel({
    this.time,
    required this.name,
    required this.totalPoints,
    required this.correct,
    required this.incorrect,
    required this.skipped,
    required this.currentQuestion,
  });

  QuizInfoModel copyWith({
    Stopwatch? time,
    String? name,
    int? totalPoints,
    int? correct,
    int? incorrect,
    int? skipped,
    int? currentQuestion,
  }) {
    return QuizInfoModel(
      time: time ?? this.time,
      name: name ?? this.name,
      totalPoints: totalPoints ?? this.totalPoints,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      skipped: skipped ?? this.skipped,
      currentQuestion: currentQuestion ?? this.currentQuestion,
    );
  }

  QuizInfoModel.empty()
      : this(
          time: null,
          name: "",
          totalPoints: 0,
          correct: 0,
          incorrect: 0,
          skipped: 0,
          currentQuestion: 0,
        );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time?.elapsed.inMilliseconds,
      'name': name,
      'totalPoints': totalPoints,
      'correct': correct,
      'incorrect': incorrect,
      'skipped': skipped,
    };
  }
}
