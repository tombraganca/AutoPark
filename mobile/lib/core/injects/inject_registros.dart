import 'package:auto_park/registros/cubit/registros_cubit.dart';
import 'package:get_it/get_it.dart';

void injectRegistros(GetIt getIt) {
  getIt.registerLazySingleton<RegistrosCubit>(() => RegistrosCubit());
}
