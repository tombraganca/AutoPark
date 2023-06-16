import 'package:equatable/equatable.dart';

class NotificacaoState extends Equatable {
  const NotificacaoState({required this.statusNotificacao});
  final StatusNotificacao statusNotificacao;
  @override
  List<Object?> get props => [statusNotificacao];

  NotificacaoState copyWith({
    StatusNotificacao? statusNotificacao,
  }) {
    return NotificacaoState(
      statusNotificacao: statusNotificacao ?? this.statusNotificacao,
    );
  }
}

enum StatusNotificacao {
  initial,
  enviando,
  falha,
  sucesso,
}
