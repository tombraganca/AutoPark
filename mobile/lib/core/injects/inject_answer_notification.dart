import 'package:auto_park/core/data/datasources/answer_notification_datasource.dart';
import 'package:auto_park/core/data/repositories/answer_notification_repository_imp.dart';
import 'package:auto_park/core/domain/repositories/answer_notification.dart';
import 'package:auto_park/core/domain/usecases/answer_notification_usecase.dart';
import 'package:get_it/get_it.dart';

void initInjectAnswerNotificacao(GetIt getIt) {
  getIt.registerLazySingleton<AnswerNotificationDataSource>(
      () => AnswerNotificationDataSourceImp(getIt()));
  getIt.registerLazySingleton<AnswerNotificationUseCase>(
      () => AnswerNotificationUseCaseImp(getIt()));
  getIt.registerLazySingleton<AnswerNotificationRepository>(
      () => AnswerNotificationRepositoryImp(getIt()));
}
