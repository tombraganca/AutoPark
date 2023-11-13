import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class EstacionamentoRepository {
  Future<Either<Failure, List<EstacionamentoEntity>>> getEstacionamentos(
      {required String token});
  Future<Either<Failure, bool>> createEstacionamento({required String token});
}
