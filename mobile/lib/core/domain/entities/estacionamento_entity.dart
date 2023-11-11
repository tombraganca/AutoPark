import 'package:auto_park/core/domain/entities/localizacao_entity.dart';

class EstacionamentoEntity {
  final int parkingId;
  final String nomeEstacionamento;
  final String endereco;
  final LocalizacaoEntity localizacaoEntity;
  EstacionamentoEntity({
    required this.parkingId,
    required this.endereco,
    required this.nomeEstacionamento,
    required this.localizacaoEntity,
  });
}
