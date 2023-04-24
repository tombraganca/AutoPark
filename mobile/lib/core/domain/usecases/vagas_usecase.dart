import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:auto_park/core/domain/repositories/vagas_respository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class VagasUseCase {
  Future<Either<Failure, List<VagaEntity>>> getVagas();
}

class VagasUseCaseImp implements VagasUseCase {
  final VagasRepository _vagasRepository;
  VagasUseCaseImp(this._vagasRepository);
  @override
  Future<Either<Failure, List<VagaEntity>>> getVagas() async {
    return await _vagasRepository.getVagas();
  }
}
