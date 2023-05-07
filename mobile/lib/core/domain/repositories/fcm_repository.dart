import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class FcmRespository {
  Future<Either<Failure, bool>> saveTokenDispositivo(String token);
}
