import 'package:fpdart/fpdart.dart';
import 'package:socialx/core/constants/constants.dart';
import 'package:socialx/core/error/exception.dart';
import 'package:socialx/core/error/failures.dart';
import 'package:socialx/core/network/connection_checker.dart';
import 'package:socialx/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:socialx/core/common/entities/user.dart';
import 'package:socialx/features/auth/data/models/user_model.dart';
import 'package:socialx/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDataSource, this.connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return Left(Failure("User is not logged in"));
        } else {
          return Right(
            UserModel(
              id: session.user.id,
              email: session.user.email!,
              name: '',
            ),
          );
        }
      }

      final user = await remoteDataSource.getCurrentUserData();

      if (user == null) {
        return Left(Failure("User is not logged in"));
      }

      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInwithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpwithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    return _getUser(
      () async => await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(Constants.noConnectionErrorMsg));
      }

      final user = await fn();

      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
