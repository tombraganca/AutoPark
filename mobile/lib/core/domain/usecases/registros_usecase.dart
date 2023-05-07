import 'package:auto_park/core/data/dtos/registros_dto.dart';
import 'package:auto_park/core/domain/repositories/registros_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class RegistrosUseCase {
  Future<Either<Failure, List<RegistroDto>>> getRegistros();
}

class RegistrosUseCaseImp implements RegistrosUseCase {
  final RegistrosRepository _registrosRepository;
  RegistrosUseCaseImp(this._registrosRepository);
  @override
  Future<Either<Failure, List<RegistroDto>>> getRegistros() async {
    return await _registrosRepository.getRegistros();
  }
}
