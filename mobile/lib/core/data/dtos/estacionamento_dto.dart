import 'package:auto_park/core/data/dtos/localizacao_dto.dart';
import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';

class EstacionamentoDto extends EstacionamentoEntity {
  EstacionamentoDto({
    required super.parkingId,
    required super.endereco,
    required super.nomeEstacionamento,
    required super.localizacaoEntity,
  });

  static EstacionamentoDto fromJson(Map<String, dynamic> json) {
    return EstacionamentoDto(
        parkingId: json['id'] ?? "",
        endereco: json['endereco'] ?? "",
        nomeEstacionamento: json['name'] ?? '',
        localizacaoEntity: LocalizacaoDto.fromJson(json));
  }
}
