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
      log(response.toString());
      users = response.map((user) => UserModel.fromMap(user)).toList();

      return users;
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } on TypeError catch (e) {
      log(e.stackTrace.toString());
      throw const ServerException(message: 'Error with getting users.');
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log("Error with getting users: ${e.runtimeType}");
      log("Error: $e");

      throw const ServerException();
    }
  }
}
