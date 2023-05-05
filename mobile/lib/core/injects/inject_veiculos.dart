import 'package:auto_park/core/data/datasources/veiculo_datasource.dart';
import 'package:auto_park/core/data/repositories/veiculo_repository_imp.dart';
import 'package:auto_park/core/domain/repositories/veiculo_repository.dart';
import 'package:auto_park/core/domain/usecases/veiculo_usecase.dart';
import 'package:auto_park/veiculos/cubit/veiculos_cubit.dart';
import 'package:get_it/get_it.dart';

void injectVeiculos(GetIt getIt) {
  getIt.registerLazySingleton<VehicleDataSource>(
      () => VehicleDataSourceImp(getIt()));

  getIt.registerLazySingleton<VehicleUseCase>(() => VehicleUseCaseImp(getIt()));

  getIt.registerLazySingleton<VehicleRepository>(
      () => VehicleRepositoryImp(getIt()));

  getIt.registerFactory<VeiculosCubit>(
      () => VeiculosCubit(vehicleUseCase: getIt()));
}
