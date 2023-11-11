import 'package:auto_park/core/domain/entities/pagamento_entity.dart';

class PagamentosDto extends PagamentosEntity {
  PagamentosDto({
    required super.nomeEstacionamento,
    required super.valor,
    required super.dataAbertura,
    required super.dataVencimento,
    required super.dataPagamento,
    required super.status,
  });
}
