import 'package:auto_park/core/domain/entities/pagamento_entity.dart';
import 'package:auto_park/features/pagamentos/cubit/pagamentos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectListPagamentos { emAberto, vencidos, pagos }

class PagamentosCubit extends Cubit<PagamentosState> {
  PagamentosCubit()
      : super(
            const PagamentosState(statusPagamentos: StatusPagamentos.initial));

  void changeList(SelectListPagamentos type) {
    final Map<SelectListPagamentos, List<PagamentosEntity>> map = {
      SelectListPagamentos.emAberto: [
        PagamentosEntity(
            status: 'em aberto',
            nomeEstacionamento: 'Estacionamento da Maria',
            valor: '150.00',
            dataAbertura: '13/11/2023',
            dataVencimento: '20/11/2023',
            dataPagamento: '')
      ],
      SelectListPagamentos.pagos: [
        PagamentosEntity(
            status: 'pago',
            nomeEstacionamento: 'Estacionamento da Maria',
            valor: '150.00',
            dataAbertura: '13/10/2023',
            dataVencimento: '',
            dataPagamento: '18/10/2023')
      ],
      SelectListPagamentos.vencidos: [
        PagamentosEntity(
            status: 'vencido',
            nomeEstacionamento: 'Estacionamento da Maria',
            valor: '150.00',
            dataAbertura: '10/09/2023',
            dataVencimento: '20/09/2023',
            dataPagamento: '')
      ],
    };
    emit(state.copyWith(
        selectListPagamentos: type,
        selectedListPagamentos: map[type],
        statusPagamentos: state.statusPagamentos == StatusPagamentos.loadedList
            ? StatusPagamentos.refrashLoadedList
            : StatusPagamentos.loadedList));
  }

  void getPagamentos() {}
}
