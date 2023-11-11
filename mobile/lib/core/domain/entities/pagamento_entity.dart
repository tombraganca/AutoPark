// ignore_for_file: public_member_api_docs, sort_constructors_first
class PagamentosEntity {
  final String nomeEstacionamento;
  final String status;
  final String valor;
  final String dataAbertura;
  final String dataVencimento;
  final String dataPagamento;
  PagamentosEntity({
    required this.status,
    required this.nomeEstacionamento,
    required this.valor,
    required this.dataAbertura,
    required this.dataVencimento,
    required this.dataPagamento,
  });
}
