import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class AnswerNotificationDataSource {
  Future<void> answerNotification(String placa, bool answer);
}

class AnswerNotificationDataSourceImp implements AnswerNotificationDataSource {
  final HttpConnectionsService _httpConnectionsService;
  AnswerNotificationDataSourceImp(this._httpConnectionsService);
  @override
  Future<void> answerNotification(String placa, bool answer) async {
    try {
      Response response = await _httpConnectionsService
          .post(answer ? 'addAccess' : 'exitAcess', {'plate': placa});
    } catch (e) {}
  }
}
