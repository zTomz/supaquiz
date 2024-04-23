import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/utils/constants/strings.dart';
import '../../../../core/config/utils/errors/exeptions.dart';
import '../../../../core/config/utils/resources/supabase.dart';
import '../models/quiz_model.dart';
import '../params/quiz_params.dart';


abstract class QuizRemoteDataSource {
  Future<QuizModel> getQuiz({required QuizParams params});

  Future<QuizModel> uploadQuizToDatabase({required QuizModel quiz});

  Future<void> updatePoints({required int offsetPoints});
}

class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  final Dio dio;

  QuizRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<QuizModel> getQuiz({required QuizParams params}) async {
    // TODO: Implement token
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
        });
      } else {
        await supabase.from('users').update({
          'quizzes': [
            ...t.first['quizzes'],
            quiz.toJson(),
          ],
        }).match({'user_id': supabase.auth.currentUser!.id});
      }
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      debugPrint(
          "Error with uploadQuizToDatabase: $e, Error type: ${e.runtimeType}");
      throw const ServerException();
    }

    return quiz;
  }

  @override
  Future<void> updatePoints({required int offsetPoints}) async {
    try {
      // Check if a row with the same id already exists
      final t = await supabase
          .from('users')
          .select()
          .eq('user_id', supabase.auth.currentUser!.id);

      if (t.isEmpty) {
        await supabase.from('users').insert({
          'points': offsetPoints,
        });
      } else {
        await supabase.from('users').update({
          'points': t.first['points'] + offsetPoints,
        }).match({'user_id': supabase.auth.currentUser!.id});
      }
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      debugPrint(
          "Error with updatePoints: $e, Error type: ${e.runtimeType}");
      throw const ServerException();
    }
  }
}
