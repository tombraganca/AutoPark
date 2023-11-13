import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';
import 'package:auto_park/core/domain/repositories/estacionamento_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class EstacionamentoUseCase {
  Future<Either<Failure, List<EstacionamentoEntity>>> getEstacionamentos(
      {required String token});
  Future<Either<Failure, bool>> createEstacionamento({required String token});
}

class EstacionamentoUseCaseImp extends EstacionamentoUseCase {
  final EstacionamentoRepository _estacionamentoRepository;
  EstacionamentoUseCaseImp(this._estacionamentoRepository);
  @override
  Future<Either<Failure, bool>> createEstacionamento(
      {required String token}) async {
    return await _estacionamentoRepository.createEstacionamento(token: token);
  }

  @override
  Future<Either<Failure, List<EstacionamentoEntity>>> getEstacionamentos(
      {required String token}) async {
    return await _estacionamentoRepository.getEstacionamentos(token: token);
  }
}
