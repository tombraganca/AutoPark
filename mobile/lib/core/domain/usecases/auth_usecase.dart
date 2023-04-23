import 'package:auto_park/core/domain/repositories/auth_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class AuthUseCase {
  Future<Either<Failure, Map<String, dynamic>>> auth(
      {required String email, required String password});
  Future<Either<Failure, Map<String, dynamic>>> create(
      {required String email, required String password});
  Future<Either<Failure, void>> delete();

  Future<Either<Failure, Stream<Map<String, dynamic>>>> read();
}

class AuthUseCaseImp implements AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCaseImp(this._authRepository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> auth(
      {required String email, required String password}) async {
    return await _authRepository.auth(email, password);
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> create(
      {required String email, required String password}) async {
    return await _authRepository.create(email, password);
  }

  @override
  Future<Either<Failure, void>> delete() async {
    return await _authRepository.delete();
  }

  @override
  Future<Either<Failure, Stream<Map<String, dynamic>>>> read() async {
    return await _authRepository.read();
  }
}
