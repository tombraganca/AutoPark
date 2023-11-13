import 'package:auto_park/core/failures/notificacao/notificacao_failure.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class AnswerNotificationDataSource {
  Future<bool> answerNotification(String placa, bool answer, String parkingId);
}

class AnswerNotificationDataSourceImp implements AnswerNotificationDataSource {
  final HttpConnectionsService _httpConnectionsService;
  AnswerNotificationDataSourceImp(this._httpConnectionsService);
  @override
  Future<bool> answerNotification(
      String placa, bool answer, String parkingId) async {
    try {
      Response response = await _httpConnectionsService.post(
        'access',
        {
          'accessType': answer ? 'in' : 'out',
          'plate': placa,
          'parkingId': parkingId,
        },
      );
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw NotificacaoFailure(e.toString());
    }
  }
}
