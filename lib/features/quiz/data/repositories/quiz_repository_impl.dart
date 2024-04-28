import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/errors/failure.dart';
import '../data_sources/quiz_remote_data_source.dart';
import '../models/quiz_model.dart';
import '../params/quiz_params.dart';

abstract class QuizRepository {
  Future<Either<Failure, QuizModel>> getQuiz({
    required QuizParams params,
  });

  Future<Either<Failure, QuizModel>> uploadQuizToDatabase({
    required QuizModel quiz,
  });

  Future<Either<Failure, void>> updatePoints({required int offsetPoints});

  Future<Either<Failure, void>> loadSessionToken();
}

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;

  QuizRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, QuizModel>> getQuiz({
    required QuizParams params,
  }) async {
    try {
      final quiz = await remoteDataSource.getQuiz(params: params);

      return Right(quiz);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.message ?? 'Failed to fetch quiz from the server.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, QuizModel>> uploadQuizToDatabase({
    required QuizModel quiz,
  }) async {
    try {
      final result = await remoteDataSource.uploadQuizToDatabase(quiz: quiz);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.message ?? 'Failed to upload quiz to the server.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> updatePoints(
      {required int offsetPoints}) async {
    try {
      await remoteDataSource.updatePoints(offsetPoints: offsetPoints);

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.message ?? 'Failed to update points on the server.',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, void>> loadSessionToken() async {
    try {
      await remoteDataSource.loadSessionToken();

      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.message ?? 'Failed to load session token.',
        ),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          errorMessage: 'Failed to load session token.',
        ),
      );
    }
  }
}