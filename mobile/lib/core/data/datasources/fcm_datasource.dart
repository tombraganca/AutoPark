import 'dart:convert';

import 'package:auto_park/core/failures/fcm/fcm_failure.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class FcmDataSource {
  Future<bool> saveTokenDispositivo(String token);
}

class FcmDataSourceImp implements FcmDataSource {
  final HttpConnectionsService _httpConnectionsService;
  FcmDataSourceImp(this._httpConnectionsService);
  @override
  Future<bool> saveTokenDispositivo(String token) async {
    try {
      Response response =
          await _httpConnectionsService.post('token', {'token': token});
      if (response.statusCode == 200 &&
          jsonDecode(response.body)['status'].toString().contains('Success')) {
        return true;
      }
      return false;
    } catch (e) {
      throw FcmFailure(e.toString());
    }
  }
}
