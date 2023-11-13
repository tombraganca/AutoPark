import 'package:auto_park/core/domain/entities/vaga_entity.dart';

class VagaDto extends VagaEntity {
  VagaDto({
    required super.name,
    required super.description,
    required super.situacao,
    required super.tipoVaga,
    required super.id,
  });

  factory VagaDto.fromJson(Map<String, dynamic> json) {
    return VagaDto(
      name: json['title'] ?? "",
      description: json['description'] ?? "",
      situacao: json['situation'] ?? "",
      tipoVaga: json['type'].toString().toLowerCase().contains('normal')
          ? TipoVaga.commun
          : json['type'].toString().toLowerCase().contains('deficient')
              ? TipoVaga.pcd
              : TipoVaga.idoso,
      id: json['id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': super.name,
      'description': super.description,
      'situation': super.situacao,
      'type': super.tipoVaga,
      'id': super.id,
    };
  }
}
