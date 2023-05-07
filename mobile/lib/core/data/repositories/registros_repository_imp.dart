import 'package:auto_park/core/data/datasources/registros_datasource.dart';
import 'package:auto_park/core/data/dtos/registros_dto.dart';
import 'package:auto_park/core/domain/repositories/registros_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

class RegistrosRepositoryImp implements RegistrosRepository {
  final RegistrosDataSource _registrosDataSource;
  RegistrosRepositoryImp(this._registrosDataSource);
  @override
  Future<Either<Failure, List<RegistroDto>>> getRegistros() async {
    try {
      return Right(await _registrosDataSource.getRegistros());
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
