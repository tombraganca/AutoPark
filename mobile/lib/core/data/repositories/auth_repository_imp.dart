import 'package:auto_park/core/data/datasources/auth_datasource.dart';
import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/domain/repositories/auth_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource _authDataSource;
  AuthRepositoryImp(this._authDataSource);
  @override
  Future<Either<Failure, UserEntity>> auth(
      String email, String password) async {
    try {
      return Right(await _authDataSource.auth(email, password));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> create(String email, String password) async {
    try {
      return Right(await _authDataSource.create(email, password));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> delete(String email, String password) async {
    try {
      return Right(await _authDataSource.delete(email, password));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
