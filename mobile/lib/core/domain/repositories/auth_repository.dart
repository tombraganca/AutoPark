import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> auth(String email, String password);
  Future<Either<Failure, bool>> create(String email, String password);
  Future<Either<Failure, bool>> delete(String email, String password);
}
