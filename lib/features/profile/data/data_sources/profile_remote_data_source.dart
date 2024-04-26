import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/resources/supabase.dart';

abstract class ProfileRemoteDataSource {
  Future<void> updateProfile({required String username});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<void> updateProfile({required String username}) async {
    try {
      // Update the user in Supabase Auth
      await supabase.auth.updateUser(
        UserAttributes(
          data: {'username': username},
        ),
      );

      // Update the user in Supabase Database
      await supabase.from('users').update({'username': username}).eq(
        'user_id',
        supabase.auth.currentUser!.id,
      );
    } on PostgrestException catch (e) {
      throw ServerException(message: e.message);
    } catch (e) {
      // If an unexpected error occurs, print the type of the error
      log(
        "Error with updating profile: $e, Error type: ${e.runtimeType}",
      );
      throw const ServerException();
    }
  }
}
