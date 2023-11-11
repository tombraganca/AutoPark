import 'package:auto_park/features/pagamentos/cubit/pagamentos_cubit.dart';
import 'package:get_it/get_it.dart';

void injectPagamentos(GetIt getIt) {
  getIt.registerFactory<PagamentosCubit>(() => PagamentosCubit());
}
