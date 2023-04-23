import 'package:auto_park/core/domain/entities/vehicle_entity.dart';

class VehicleDto extends VehicleEntity {
  VehicleDto(
      {required super.name,
      required super.marca,
      required super.modelo,
      required super.placa});

  factory VehicleDto.fromJson(Map<String, dynamic> json) {
    return VehicleDto(
        name: json['name'],
        marca: json['marca'],
        modelo: json['modelo'],
        placa: json['placa']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': super.name,
      'marca': super.marca,
      'modelo': super.modelo,
      'placa': super.placa,
    };
  }
}
