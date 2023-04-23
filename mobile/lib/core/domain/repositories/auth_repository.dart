import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class AuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> auth(
      String email, String password);
  Future<Either<Failure, Map<String, dynamic>>> create(
      String email, String password);
  Future<Either<Failure, void>> delete();

  Future<Either<Failure, Stream<Map<String, dynamic>>>> read();
}
