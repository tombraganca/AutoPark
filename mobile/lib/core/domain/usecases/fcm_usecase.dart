import 'package:auto_park/core/domain/repositories/fcm_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class FcmUseCase {
  Future<Either<Failure, bool>> saveTokenDispositivo(String token);
}

class FcmUseCaseImp implements FcmUseCase {
  final FcmRespository _fcmRespository;
  FcmUseCaseImp(this._fcmRespository);
  @override
  Future<Either<Failure, bool>> saveTokenDispositivo(String token) async {
    return await _fcmRespository.saveTokenDispositivo(token);
  }
}
