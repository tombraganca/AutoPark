import 'package:auto_park/core/data/datasources/estacionamento_datasource.dart';
import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';
import 'package:auto_park/core/domain/repositories/estacionamento_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

class EstacionamentoRepositoryImp extends EstacionamentoRepository {
  final EstacionamentoDataSource _estacionamentoDataSource;
  EstacionamentoRepositoryImp(this._estacionamentoDataSource);
  @override
  Future<Either<Failure, bool>> createEstacionamento(
      {required String token}) async {
    try {
      return Right(
          await _estacionamentoDataSource.createEstacionamento(token: token));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<EstacionamentoEntity>>> getEstacionamentos(
      {required String token}) async {
    try {
      return Right(
          await _estacionamentoDataSource.getEstacionamentos(token: token));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
