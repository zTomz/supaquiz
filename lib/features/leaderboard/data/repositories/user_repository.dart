import 'package:fpdart/fpdart.dart';

import '../../../../core/utils/errors/exeptions.dart';
import '../../../../core/utils/errors/failure.dart';
import '../data_sources/user_remote_data_source.dart';
import '../models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserModel>>> getUsers();
}

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<UserModel>>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();

      return Right(users);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          errorMessage: e.message ?? 'Failed to fetch users from the server.',
        ),
      );
    }
  }
}
