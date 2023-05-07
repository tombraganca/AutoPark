import 'package:auto_park/core/services/firebase_messaging.dart';
import 'package:auto_park/packages/firebase_messaging_service_imp.dart';
import 'package:get_it/get_it.dart';

void injectFirebaseMessaging(GetIt getIt) {
  getIt.registerLazySingleton<FirebaseMessagingService>(
      () => FirebaseMessagingServiceImp(getIt()));
}
