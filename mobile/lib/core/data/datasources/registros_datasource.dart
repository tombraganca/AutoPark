import 'dart:convert';

import 'package:auto_park/core/data/dtos/registros_dto.dart';
import 'package:auto_park/core/failures/registros/registros_failure.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class RegistrosDataSource {
  Future<List<RegistroDto>> getRegistros();
}

class RegistrosDataSourceImp implements RegistrosDataSource {
  final HttpConnectionsService _httpConnectionsService;
  RegistrosDataSourceImp(this._httpConnectionsService);
  @override
  Future<List<RegistroDto>> getRegistros() async {
    try {
      Response response = await _httpConnectionsService.get('listAccess');
      if (response.statusCode == 200) {
        return (jsonDecode(response.body)[''] as List<dynamic>)
            .map((e) => RegistroDto.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw RegistrosFailure(e.toString());
    }
  }
}
