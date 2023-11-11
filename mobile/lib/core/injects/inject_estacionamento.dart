import 'package:auto_park/features/estacionamentos/cubit/estacionamento_cubit.dart';
import 'package:get_it/get_it.dart';

void injectEstacionamento(GetIt getIt) {
  getIt.registerFactory<EstacionamentoCubit>(() => EstacionamentoCubit());
}
