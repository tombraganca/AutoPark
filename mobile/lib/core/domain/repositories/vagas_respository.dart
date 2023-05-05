import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class VagasRepository {
  Future<Either<Failure, List<VagaEntity>>> getVagas(String token);
}
