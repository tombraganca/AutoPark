import 'package:auto_park/core/domain/entities/vaga_entity.dart';

class VagaDto extends VagaEntity {
  VagaDto(
      {required super.name,
      required super.reportes,
      required super.description,
      required super.isAvailable,
      required super.tipoVaga});

  factory VagaDto.fromJson(Map<String, dynamic> json) {
    return VagaDto(
      name: json['name'],
      reportes: json['reportes'],
      description: json['description'],
      isAvailable: json['isAvailable'],
      tipoVaga: json['tipovaga'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': super.name,
      'reportes': super.reportes,
      'description': super.description,
      'isAvailable': super.isAvailable,
      'tipoVaga': super.tipoVaga,
    };
  }
}
