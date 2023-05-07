import 'package:auto_park/core/data/datasources/fcm_datasource.dart';
import 'package:auto_park/core/domain/repositories/fcm_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

class FcmRepositoryImp implements FcmRespository {
  final FcmDataSource _fcmDataSource;
  FcmRepositoryImp(this._fcmDataSource);
  @override
  Future<Either<Failure, bool>> saveTokenDispositivo(String token) async {
    try {
      return Right(await _fcmDataSource.saveTokenDispositivo(token));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
