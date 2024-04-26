import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/resources/supabase.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<List<UserModel>> getUsers() async {
    try {
      List<UserModel> users = [];

      final response = await supabase.from('users').select();
      users = response.map((e) => UserModel.fromJson(e)).toList();

      return users;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log("Error with getting users: $e, Error type: ${e.runtimeType}");
      throw const ServerException();
    }
  }
}
