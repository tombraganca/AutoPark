import 'package:auto_park/core/data/datasources/auth_datasource.dart';
import 'package:auto_park/core/domain/repositories/auth_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource _authDataSource;
  AuthRepositoryImp(this._authDataSource);
  @override
  Future<Either<Failure, Map<String, dynamic>>> auth(
      String email, String password) async {
    try {
      return Right(await _authDataSource.auth(email, password));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> create(
      String email, String password) async {
    try {
      return Right(await _authDataSource.create(email, password));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, void>> delete() async {
    try {
      return Right(await _authDataSource.delete());
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, Stream<Map<String, dynamic>>>> read() async {
    try {
      return Right(await _authDataSource.read());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
