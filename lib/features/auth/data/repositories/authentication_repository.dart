import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/extensions/snack_bar_extension.dart';
import '../../../../core/utils/resources/supabase.dart';

abstract class AuthenticationRepository {
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  });

  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  });
}

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  static final AuthenticationRepositoryImpl _instance =
      AuthenticationRepositoryImpl._internal();

  factory AuthenticationRepositoryImpl() {
    return _instance;
  }

  AuthenticationRepositoryImpl._internal();

  @override
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthApiException catch (e) {
      if (context.mounted) {
        context.showSnackBar(message: e.message);
      }
    } catch (e) {
      log("Failed to authenticate: $e, Error type: ${e.runtimeType}");
    }
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
    required String username,
    required BuildContext context,
  }) async {
    try {
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {"username": username},
      );

      await _createEntryInDatabase(response);
    } on AuthApiException catch (e) {
      if (context.mounted) {
        context.showSnackBar(message: e.message);
      }
    } on ServerException catch (e) {
      if (context.mounted) {
        context.showSnackBar(message: e.message ?? 'Server Error');
      }
    } catch (e) {
      log("Failed to authenticate: $e, Error type: ${e.runtimeType}");
    }
  }

  /// Onyl used when signing up
  Future<void> _createEntryInDatabase(AuthResponse response) async {
    try {
      await supabase.from('users').insert({
        'user_id': response.user!.id,
        'username': response.user!.userMetadata!['username'],
        'quizzes': [],
      });
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log(
        "Error with _createEntryInDatabase: $e, Error type: ${e.runtimeType}",
      );
    }
  }
}
