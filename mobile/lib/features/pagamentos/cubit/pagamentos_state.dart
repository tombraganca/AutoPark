// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/domain/entities/pagamento_entity.dart';
import 'package:auto_park/features/pagamentos/cubit/pagamentos_cubit.dart';
import 'package:equatable/equatable.dart';

class PagamentosState extends Equatable {
  final StatusPagamentos statusPagamentos;
  final SelectListPagamentos selectListPagamentos;
  final Map<SelectListPagamentos, List<PagamentosEntity>> mapPagamentos;
  final List<PagamentosEntity> selectedListPagamentos;
  const PagamentosState({
    required this.statusPagamentos,
    this.selectedListPagamentos = const [],
    this.mapPagamentos = const {
      SelectListPagamentos.emAberto: [],
      SelectListPagamentos.pagos: [],
      SelectListPagamentos.vencidos: [],
    },
    this.selectListPagamentos = SelectListPagamentos.emAberto,
  });
  @override
  List<Object?> get props => [
        statusPagamentos,
        selectListPagamentos,
        mapPagamentos,
        selectedListPagamentos,
      ];

  PagamentosState copyWith({
    StatusPagamentos? statusPagamentos,
    SelectListPagamentos? selectListPagamentos,
    Map<SelectListPagamentos, List<PagamentosEntity>>? mapPagamentos,
    List<PagamentosEntity>? selectedListPagamentos,
  }) {
    return PagamentosState(
      statusPagamentos: statusPagamentos ?? this.statusPagamentos,
      selectListPagamentos: selectListPagamentos ?? this.selectListPagamentos,
      mapPagamentos: mapPagamentos ?? this.mapPagamentos,
      selectedListPagamentos:
          selectedListPagamentos ?? this.selectedListPagamentos,
    );
  }
}

enum StatusPagamentos { initial, loadingList, loadedList, refrashLoadedList }
