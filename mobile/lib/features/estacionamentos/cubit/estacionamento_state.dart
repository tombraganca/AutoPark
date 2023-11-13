// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';
import 'package:equatable/equatable.dart';

class EstacionamentoState extends Equatable {
  final StatusEstacionamento statusEstacionamento;
  final List<EstacionamentoEntity> listEstacionamentos;
  const EstacionamentoState({
    required this.statusEstacionamento,
    this.listEstacionamentos = const [],
  });
  @override
  List<Object?> get props => [
        statusEstacionamento,
        listEstacionamentos,
      ];

  EstacionamentoState copyWith({
    StatusEstacionamento? statusEstacionamento,
    List<EstacionamentoEntity>? listEstacionamentos,
  }) {
    return EstacionamentoState(
      statusEstacionamento: statusEstacionamento ?? this.statusEstacionamento,
      listEstacionamentos: listEstacionamentos ?? this.listEstacionamentos,
    );
  }
}

enum StatusEstacionamento {
  initial,
  buscandoEstacionamentos,
  loadedListEstacionamentos,
  failureGetListEstacionamentos,
}
