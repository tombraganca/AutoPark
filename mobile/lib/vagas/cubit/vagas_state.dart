// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:auto_park/vagas/cubit/vagas_cubit.dart';
import 'package:equatable/equatable.dart';

enum StatusVagas { initial, loadedList, refrashLoadedList }

class VagasState extends Equatable {
  final StatusVagas statusVagas;
  final SelectListVagas? selectListVagas;
  final List<VagaEntity> listVagas;

  @override
  List<Object?> get props => [statusVagas];
  const VagasState(
      {required this.statusVagas,
      this.selectListVagas,
      this.listVagas = const []});

  VagasState copyWith({
    StatusVagas? statusVagas,
    SelectListVagas? selectListVagas,
    List<VagaEntity>? listVagas,
  }) {
    return VagasState(
      statusVagas: statusVagas ?? this.statusVagas,
      selectListVagas: selectListVagas ?? this.selectListVagas,
      listVagas: listVagas ?? this.listVagas,
    );
  }
}
