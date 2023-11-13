import 'package:auto_park/features/minha_conta/cubit/minha_conta_cubit.dart';
import 'package:get_it/get_it.dart';

void injectMinhaConta(GetIt getIt) {
  getIt.registerLazySingleton<MinhaContaCubit>(() => MinhaContaCubit());
}
