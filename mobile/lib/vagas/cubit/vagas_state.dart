// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:auto_park/vagas/cubit/vagas_cubit.dart';
import 'package:equatable/equatable.dart';

class VagasState extends Equatable {
  final StatusVagas statusVagas;
  final SelectListVagas? selectListVagas;
  final Map<SelectListVagas, List<VagaEntity>> maplistVagas;
  final List<VagaEntity> listSelected;

  @override
  List<Object?> get props =>
      [statusVagas, maplistVagas, selectListVagas, listSelected];
  const VagasState(
      {required this.statusVagas,
      this.selectListVagas,
      this.listSelected = const [],
      this.maplistVagas = const {
        SelectListVagas.disponivel: [],
        SelectListVagas.todas: [],
      }});

  VagasState copyWith({
    StatusVagas? statusVagas,
    SelectListVagas? selectListVagas,
    List<VagaEntity>? listSelected,
    Map<SelectListVagas, List<VagaEntity>>? maplistVagas,
  }) {
    return VagasState(
      statusVagas: statusVagas ?? this.statusVagas,
      selectListVagas: selectListVagas ?? this.selectListVagas,
      maplistVagas: maplistVagas ?? this.maplistVagas,
      listSelected: listSelected ?? this.listSelected,
    );
  }
}

enum StatusVagas {
  initial,
  buscandoVagas,
  errorBuscarVagas,
  sucessoBuscarVagas,
  selectList,
  refrashselectList
}
