import 'package:auto_park/core/domain/entities/vehicle_entity.dart';

class VehicleDto extends VehicleEntity {
  VehicleDto(
      {required super.id,
      required super.marca,
      required super.modelo,
      required super.placa});

  factory VehicleDto.fromJson(Map<String, dynamic> json) {
    return VehicleDto(
        id: json['ownerId'] ?? '',
        marca: json['manufacturer'] ?? "",
        modelo: json['model'] ?? '',
        placa: json['plate'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'marca': super.marca,
      'modelo': super.modelo,
      'placa': super.placa,
    };
  }

  factory VehicleDto.empty() {
    return VehicleDto(id: '', marca: '', modelo: '', placa: '');
  }
}
