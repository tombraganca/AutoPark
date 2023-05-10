import 'package:auto_park/core/data/dtos/notification_dto.dart';
import 'package:auto_park/core/data/dtos/user_dto.dart';
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/core/functions/toasts.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/core/rotas/routes_app.dart';
import 'package:auto_park/core/services/firebase_messaging.dart';
import 'package:auto_park/core/services/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';

class FirebaseMessagingServiceImp
    with ToastMessages
    implements FirebaseMessagingService {
  final NotificationService _notificationService;
  FirebaseMessagingServiceImp(
    this._notificationService,
  );
  @override
  Future<void> initialize() async {
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      badge: true,
      sound: true,
      alert: true,
    );
    onMessage();
    onMessageOpenApp();
  }

  @override
  Future<String> getDeviceFirebaseToken() async =>
      await FirebaseMessaging.instance.getToken() ?? '';

  @override
  void onMessage() {
    FirebaseMessaging.onMessage.listen(
      ((message) {
        if (message.notification != null) {
          _notificationService.showNotification(
            NotificationDto(
              id: message.data['orderId'] ?? '',
              body: message.notification!.body!,
              title: message.notification!.title!,
              datahora: message.data['orderDate'] ?? '',
              tipoDeAcesso: message.data['accessType'] ?? '',
              vehicleEntity: VehicleEntity(
                id: '',
                marca: message.data['manufacturer'] ?? '',
                modelo: message.data['model'] ?? '',
                placa: message.data['plate'] ?? '',
              ),
            ),
          );
        }
      }),
    );
  }

  @override
  void onMessageOpenApp() =>
      FirebaseMessaging.onMessageOpenedApp.listen((_goToPageAfterMessage));

  void _goToPageAfterMessage(RemoteMessage message) {
    if (GetIt.I.get<UserDtoGlobal>().getUser().token.isNotEmpty) {
      RoutesApp.navigatorKey!.currentState!.pushNamed('NOTIFICACAO');
    } else {
      showMessageError('Realize o login para prosseguir');
    }
  }
}