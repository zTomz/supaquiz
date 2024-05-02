import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../../../core/utils/resources/session_token.dart';
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
    final repo = QuizRepositoryImpl(
      remoteDataSource: QuizRemoteDataSourceImpl(dio: Dio()),
    );

    if (sessionToken == null) {
      await repo.loadSessionToken();
    }

    final failureOrQuiz = await repo.getQuiz(
      params: params ??
          QuizParams(
            sessionToken: sessionToken,
          ),
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

        _generateAnswers();

        notifyListeners();
      },
    );
  }

  void setQuiz(QuizModel quiz, {String name = 'Random'}) {
    this.quiz = quiz;
    quizInfo = QuizInfoModel.empty().copyWith(
      time: Stopwatch()..start(),
      name: name,
    );
    failure = null;

    _generateAnswers();

    notifyListeners();
  }

  /// Upload the quiz to the database, and reset the local quiz.
  /// This also will update the points in the database, based on the total points of quiz info
  /// If an error occurs, it will be stored in the [failure] property.
  Future<void> uploadQuizToDatabase() async {
    if (quiz == null) {
      failure = ServerFailure(
        errorMessage: "No quiz to upload",
      );
      return;
    }

    final failureOrQuiz = await QuizRepositoryImpl(
      remoteDataSource: QuizRemoteDataSourceImpl(
        dio: Dio(),
      ),
    ).uploadQuizToDatabase(
      quiz: quiz!,
      quizInfo: quizInfo,
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

  void _generateAnswers() {
    if (quiz == null) {
      return;
    }

    for (QuestionModel question in quiz!.questions) {
      question.generateAnswers();
    }
  }
}
