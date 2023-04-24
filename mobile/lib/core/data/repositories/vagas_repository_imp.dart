import 'package:auto_park/core/data/datasources/vagas_datasource.dart';
import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:auto_park/core/domain/repositories/vagas_respository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

class VagasRepositoryImp implements VagasRepository {
  final VagasDataSource _vagasDataSource;
  VagasRepositoryImp(this._vagasDataSource);
  @override
  Future<Either<Failure, List<VagaEntity>>> getVagas() async {
    try {
      return Right(await _vagasDataSource.getVagas());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
