import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/constants/strings.dart';
import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/resources/session_token.dart';
import '../../../../core/utils/resources/supabase.dart';
import '../models/quiz_model.dart';
import '../params/quiz_params.dart';

abstract class QuizRemoteDataSource {
  Future<QuizModel> getQuiz({required QuizParams params});

  Future<QuizModel> uploadQuizToDatabase({required QuizModel quiz});

  Future<void> updatePoints({required int offsetPoints});

  Future<void> loadSessionToken();
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final Dio dio;

  QuizRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<QuizModel> getQuiz({required QuizParams params}) async {
    final response = await dio.get(
      kBaseUrl,
      queryParameters: {
        'encode': 'base64',
        ...params.toMap(),
      },
    );

    if (response.statusCode == 200) {
      return QuizModel.fromMap(response.data as Map<String, dynamic>);
    } else {
      throw const ServerException();
    }
  }

  @override
  Future<QuizModel> uploadQuizToDatabase({required QuizModel quiz}) async {
    final username = supabase.auth.currentUser!.userMetadata!['username'];

    try {
      // Check if a row with the same id already exists
      final t = await supabase
          .from('users')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);

      if (t.isEmpty) {
        await supabase.from('users').insert({
          'quizzes': [
            quiz.toJson(),
          ],
          'username': username,
        });
      } else {
        await supabase.from('users').update({
          'quizzes': [
            ...t.first['quizzes'],
            quiz.toJson(),
          ],
          'username': username,
        }).match({'user_id': supabase.auth.currentUser!.id});
      }
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } on TypeError catch (e) {
      throw ServerException(message: e.toString());
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log(
        "Error with uploadQuizToDatabase: $e, Error type: ${e.runtimeType}",
      );
      throw const ServerException();
    }

    return quiz;
  }

  @override
  Future<void> updatePoints({required int offsetPoints}) async {
    final username = supabase.auth.currentUser!.userMetadata!['username'];

    try {
      // Check if a row with the same id already exists
      final t = await supabase
          .from('users')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);

      if (t.isEmpty) {
        await supabase.from('users').insert({
          'points': offsetPoints,
          'username': username,
        });
      } else {
        await supabase.from('users').update({
          'points': t.first['points'] + offsetPoints,
          'username': username,
        }).match({'user_id': supabase.auth.currentUser!.id});
      }
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log("Error with updatePoints: $e, Error type: ${e.runtimeType}");
      throw const ServerException();
    }
  }

  @override
  Future<void> loadSessionToken() async {
    try {
      final response = await dio.get(
        kTokenRequestUrl,
      );

      if (response.statusCode == 200) {
        sessionToken = response.data['token'] as String;
      } else {
        throw const ServerException(message: 'Failed to get session token');
      }
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log(
        "Error with getSessionToken: $e, Error type: ${e.runtimeType}",
      );
      throw const ServerException(message: 'Failed to get session token');
    }
  }
}
