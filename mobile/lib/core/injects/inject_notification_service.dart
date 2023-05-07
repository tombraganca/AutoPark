import 'package:auto_park/core/services/notification_service.dart';
import 'package:auto_park/packages/notification_service_imp.dart';
import 'package:get_it/get_it.dart';

void injectNotificationService(GetIt getIt) {
  getIt.registerLazySingleton<NotificationService>(
      () => NotificationServiceImp());
}
