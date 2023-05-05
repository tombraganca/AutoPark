// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:equatable/equatable.dart';

class VeiculosState extends Equatable {
  final StatusVeiculos statusVeiculos;
  final List<VehicleEntity> listVehicles;
  const VeiculosState({
    required this.statusVeiculos,
    this.listVehicles = const [],
  });
  @override
  List<Object?> get props => [statusVeiculos, listVehicles];

  VeiculosState copyWith({
    StatusVeiculos? statusVeiculos,
    List<VehicleEntity>? listVehicles,
  }) {
    return VeiculosState(
      statusVeiculos: statusVeiculos ?? this.statusVeiculos,
      listVehicles: listVehicles ?? this.listVehicles,
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
