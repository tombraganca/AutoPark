import 'package:auto_park/core/data/dtos/user_dto.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserDto>> auth(String email, String password);
  Future<Either<Failure, bool>> create(
      String email, String password, String name);
  Future<Either<Failure, bool>> delete();
}
