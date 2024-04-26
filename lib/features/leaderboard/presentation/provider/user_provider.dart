import 'package:flutter/material.dart';

import '../../../../core/utils/errors/failure.dart';
import '../../data/data_sources/user_remote_data_source.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel>? users;
  Failure? failure;

  UserProvider({
    this.users,
    this.failure,
  });

  Future<void> eitherFailureOrUsers() async {
    final failureOrUsers = await UserRepositoryImpl(
      remoteDataSource: UserRemoteDataSourceImpl(),
    ).getUsers();

    failureOrUsers.fold(
      (failure) {
        this.failure = failure;
        users = null;

        notifyListeners();
      },
      (users) {
        this.users = users;
        failure = null;

        notifyListeners();
      },
    );
  }
}
