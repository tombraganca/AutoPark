import 'package:auto_park/core/data/datasources/fcm_datasource.dart';
import 'package:auto_park/core/data/repositories/fcm_repository_imp.dart';
import 'package:auto_park/core/domain/repositories/fcm_repository.dart';
import 'package:auto_park/core/domain/usecases/fcm_usecase.dart';
import 'package:get_it/get_it.dart';

void injectFcm(GetIt getIt) {
  getIt.registerLazySingleton<FcmDataSource>(() => FcmDataSourceImp(getIt()));
  getIt.registerLazySingleton<FcmUseCase>(() => FcmUseCaseImp(getIt()));
  getIt.registerLazySingleton<FcmRespository>(() => FcmRepositoryImp(getIt()));
}
