import 'package:auto_park/features/notificacao/cubit/notificacao_cubit.dart';
import 'package:get_it/get_it.dart';

void initInjectNotificacao(GetIt getIt) {
  getIt.registerFactory<NotificacaoCubit>(
      () => NotificacaoCubit(answerNotificationUseCase: getIt()));
}
