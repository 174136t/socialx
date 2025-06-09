import 'package:fpdart/fpdart.dart';
import 'package:socialx/core/error/failures.dart';
import 'package:socialx/core/usecase/usecase.dart';
import 'package:socialx/core/common/entities/user.dart';
import 'package:socialx/features/auth/domain/repository/auth_repository.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository repository;
  CurrentUser(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.currentUser();
  }
}
