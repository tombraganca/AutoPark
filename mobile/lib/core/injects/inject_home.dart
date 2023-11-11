import 'package:auto_park/features/home/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

injectHome(GetIt getIt) {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(
      registrosCubit: getIt(),
      vagasCubit: getIt(),
      veiculosCubit: getIt(),
      pagamentosCubit: getIt(),
      estacionamentoCubit: getIt(),
    ),
  );
}
