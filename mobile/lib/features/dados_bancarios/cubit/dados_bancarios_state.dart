// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class DadosBancariosState extends Equatable {
  final String numeroCartao;
  final String validadeCartao;
  final String nomeCartao;
  final String cvvCartao;
  final StatusDadosBancarios statusDadosBancarios;
  final bool showBackView;
  const DadosBancariosState(
      {this.cvvCartao = '',
      this.nomeCartao = '',
      this.showBackView = false,
      this.numeroCartao = '',
      this.validadeCartao = '',
      required this.statusDadosBancarios});
  @override
  List<Object?> get props => [
        cvvCartao,
        numeroCartao,
        showBackView,
        nomeCartao,
        validadeCartao,
      ];

  DadosBancariosState copyWith({
    String? numeroCartao,
    String? validadeCartao,
    String? nomeCartao,
    String? cvvCartao,
    bool? showBackView,
    StatusDadosBancarios? statusDadosBancarios,
  }) {
    return DadosBancariosState(
      numeroCartao: numeroCartao ?? this.numeroCartao,
      validadeCartao: validadeCartao ?? this.validadeCartao,
      nomeCartao: nomeCartao ?? this.nomeCartao,
      cvvCartao: cvvCartao ?? this.cvvCartao,
      showBackView: showBackView ?? this.showBackView,
      statusDadosBancarios: statusDadosBancarios ?? this.statusDadosBancarios,
    );
  }
}

enum StatusDadosBancarios { initial, refreshData, insertData }
