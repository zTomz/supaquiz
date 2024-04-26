import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../data/data_sources/quiz_remote_data_source.dart';
import '../../data/models/question_model.dart';
import '../../data/models/quiz_info_model.dart';
import '../../data/models/quiz_model.dart';
import '../../data/params/quiz_params.dart';
import '../../data/repositories/quiz_repository_impl.dart';

class QuizProvider extends ChangeNotifier {
  QuizModel? quiz;
  QuizInfoModel quizInfo = QuizInfoModel.empty();
  Failure? failure;

  QuizProvider({
    this.quiz,
    this.failure,
  });

  Future<void> eitherFailureOrQuiz({QuizParams? params}) async {
    final failureOrQuiz = await QuizRepositoryImpl(
      remoteDataSource: QuizRemoteDataSourceImpl(dio: Dio()),
    ).getQuiz(
      params: params ?? const QuizParams(),
    );

    failureOrQuiz.fold(
      (failure) {
        this.failure = failure;
        quiz = null;
        quizInfo = QuizInfoModel.empty();

        notifyListeners();
      },
      (quiz) {
        this.quiz = quiz;
        quizInfo = QuizInfoModel.empty().copyWith(
          time: Stopwatch()..start(),
        );
        failure = null;

        notifyListeners();
      },
    );
  }

  /// Upload the quiz to the database, and reset the local quiz.
  /// If an error occurs, it will be stored in the [failure] property.
  Future<void> uploadQuizToDatabase({
    required QuizModel quiz,
  }) async {
    final failureOrQuiz = await QuizRepositoryImpl(
      remoteDataSource: QuizRemoteDataSourceImpl(
        dio: Dio(),
      ),
    ).uploadQuizToDatabase(
      quiz: quiz,
    );

    failureOrQuiz.fold(
      (failure) {
        this.failure = failure;
      },
      (quiz) {
        failure = null;
      },
    );
  }

  Future<void> updatePoints({required int offsetPoints}) async {
    final failureOrVoid = await QuizRepositoryImpl(
      remoteDataSource: QuizRemoteDataSourceImpl(
        dio: Dio(),
      ),
    ).updatePoints(
      offsetPoints: offsetPoints,
    );

    failureOrVoid.fold(
      (failure) {
        this.failure = failure;
      },
      (quiz) {
        failure = null;
      },
    );
  }

  void updateQuizInfo({
    Stopwatch? time,
    String? name,
    int? totalPoints,
    int? correct,
    int? incorrect,
    int? skipped,
    int? currentQuestion,
  }) {
    quizInfo = quizInfo.copyWith(
      time: time,
      name: name,
      totalPoints: totalPoints,
      correct: correct,
      incorrect: incorrect,
      skipped: skipped,
      currentQuestion: currentQuestion,
    );

    notifyListeners();
  }

  void generateAnswers() {
    if (quiz == null) {
      return;
    }

    for (QuestionModel question in quiz!.questions) {
      question.generateAnswers();
    }
  }
}
