import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/domain/repositories/auth_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class AuthUseCase {
  Future<Either<Failure, UserEntity>> auth(
      {required String email, required String password});
  Future<Either<Failure, bool>> create(
      {required String email, required String password, required String name});
  Future<Either<Failure, bool>> delete();
}

class AuthUseCaseImp implements AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCaseImp(this._authRepository);
  @override
  Future<Either<Failure, UserEntity>> auth(
      {required String email, required String password}) async {
    return await _authRepository.auth(email, password);
  }

  @override
  Future<Either<Failure, bool>> create(
      {required String email,
      required String password,
      required String name}) async {
    return await _authRepository.create(email, password, name);
  }

  @override
  Future<Either<Failure, bool>> delete() async {
    return await _authRepository.delete();
  }
}
