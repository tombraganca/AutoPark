import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:equatable/equatable.dart';

class VeiculosState extends Equatable {
  final StatusVeiculos statusVeiculos;
  final List<VehicleEntity> listVehicles;
  final String erroMsg;
  const VeiculosState({
    required this.statusVeiculos,
    this.listVehicles = const [],
    this.erroMsg = '',
  });
  @override
  List<Object?> get props => [
        statusVeiculos,
        listVehicles,
        erroMsg,
      ];

  VeiculosState copyWith({
    StatusVeiculos? statusVeiculos,
    List<VehicleEntity>? listVehicles,
    String? erroMsg,
  }) {
    return VeiculosState(
      statusVeiculos: statusVeiculos ?? this.statusVeiculos,
      listVehicles: listVehicles ?? this.listVehicles,
      erroMsg: erroMsg ?? this.erroMsg,
    );
  }
}

enum StatusVeiculos {
  initial,
  carregando,
  errorBuscarVeiculos,
  sucessoVeiculos,
  reloadListVechicles,
  errorAddVeiculo,
  adicionandoVeiculo
}
