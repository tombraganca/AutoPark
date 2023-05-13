import 'package:auto_park/core/data/dtos/notification_dto.dart';
import 'package:auto_park/core/functions/toasts.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/core/rotas/routes_app.dart';
import 'package:auto_park/core/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

class NotificationServiceImp with ToastMessages implements NotificationService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  NotificationDto _notificationDto = NotificationDto.empty();
  NotificationServiceImp() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializeNotifications();
  }

  AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');

  DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings();
  @override
  Future<void> initializeNotifications() async {
    await localNotificationsPlugin.initialize(
      InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS),
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        if (GetIt.I.get<UserDtoGlobal>().getUser().token.isNotEmpty) {
          onSelectNotification(notificationResponse.payload);
        } else {
          showMessageError('Realize o login para prosseguir');
        }
      },
    );
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  void onSelectNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Navigator.pushReplacementNamed(
          RoutesApp.navigatorKey!.currentContext!, payload.toUpperCase(),
          arguments: _notificationDto);
    }
  }

  @override
  void showNotification(NotificationDto notificationDto) {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'auhappy',
      'auhappy_name',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );
    const String darwinNotificationCategoryPlain = 'plainCategory';
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );
    NotificationDetails notificationDetails = const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
    _notificationDto = notificationDto;
    localNotificationsPlugin.show(
      int.tryParse(notificationDto.id) ?? 1,
      notificationDto.title,
      notificationDto.body,
      notificationDetails,
      payload: 'NOTIFICACAO',
    );
  }
}
