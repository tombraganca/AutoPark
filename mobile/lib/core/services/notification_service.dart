import 'package:auto_park/core/data/dtos/notification_dto.dart';

abstract class NotificationService {
  Future<void> initializeNotifications();
  void onSelectNotification(String route);
  void showNotification(NotificationDto notificationDto);
}
