import 'package:auto_park/features/dados_bancarios/cubit/dados_bancarios_cubit.dart';
import 'package:get_it/get_it.dart';

void injectDadosBancarios(GetIt getIt) {
  getIt.registerFactory<DadosBancariosCubit>(() => DadosBancariosCubit());
}
