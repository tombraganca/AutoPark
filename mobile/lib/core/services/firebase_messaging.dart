abstract class FirebaseMessagingService {
  Future<void> initialize();
  Future<String> getDeviceFirebaseToken();
  void onMessage();
  void onMessageOpenApp();
}
