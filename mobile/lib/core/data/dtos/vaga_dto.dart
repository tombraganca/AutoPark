import 'package:auto_park/core/domain/entities/vaga_entity.dart';

class VagaDto extends VagaEntity {
  VagaDto({
    required super.name,
    required super.reportes,
    required super.description,
    required super.isAvailable,
    required super.tipoVaga,
    required super.id,
  });

  factory VagaDto.fromJson(Map<String, dynamic> json) {
    return VagaDto(
      name: json['name'],
      reportes: json['reportes'],
      description: json['description'],
      isAvailable: json['isAvailable'],
      tipoVaga: json['tipovaga'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': super.name,
      'reportes': super.reportes,
      'description': super.description,
      'isAvailable': super.isAvailable,
      'tipoVaga': super.tipoVaga,
      'id': super.id,
    };
  }
}
