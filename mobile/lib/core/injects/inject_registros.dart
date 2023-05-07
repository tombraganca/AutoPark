import 'package:auto_park/features/registros/cubit/registros_cubit.dart';
import 'package:get_it/get_it.dart';

void injectRegistros(GetIt getIt) {
  getIt.registerFactory<RegistrosCubit>(() => RegistrosCubit());
}
