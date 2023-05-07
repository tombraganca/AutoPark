import 'package:auto_park/core/data/dtos/registros_dto.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class RegistrosRepository {
  Future<Either<Failure, List<RegistroDto>>> getRegistros();
}
