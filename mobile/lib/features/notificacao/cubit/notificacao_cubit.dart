import 'package:auto_park/core/domain/usecases/answer_notification_usecase.dart';
import 'package:auto_park/features/notificacao/cubit/notificacao_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificacaoCubit extends Cubit<NotificacaoState> {
  final AnswerNotificationUseCase answerNotificationUseCase;
  NotificacaoCubit({required this.answerNotificationUseCase})
      : super(NotificacaoState(statusNotificacao: StatusNotificacao.initial));

  Future<void> answerNotificacao(bool answer, String placa) async {
    bool registerSucess = false;
    emit(state.copyWith(statusNotificacao: StatusNotificacao.enviando));
    var result = await answerNotificationUseCase.answerNotification(
        placa: placa, answer: answer);
    result.fold((failure) {
      emit(state.copyWith(statusNotificacao: StatusNotificacao.falha));
    }, (sucess) {
      registerSucess = sucess;
    });
    emit(state.copyWith(
        statusNotificacao: registerSucess
            ? StatusNotificacao.sucesso
            : StatusNotificacao.falha));
  }

  void reloadList() =>
      emit(state.copyWith(statusNotificacao: StatusNotificacao.initial));
}
