import 'dart:convert';

import 'package:auto_park/core/data/dtos/estacionamento_dto.dart';
import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';
import 'package:auto_park/core/failures/estacionamentos/estacionamentos_failure.dart';
import 'package:auto_park/core/services/http_connections_service.dart';

abstract class EstacionamentoDataSource {
  Future<List<EstacionamentoEntity>> getEstacionamentos(
      {required String token});
  Future<bool> createEstacionamento({required String token});
}

class EstacionamentoDataSourceImp extends EstacionamentoDataSource {
  final HttpConnectionsService _httpConnectionsService;
  EstacionamentoDataSourceImp(this._httpConnectionsService);
  @override
  Future<bool> createEstacionamento({required String token}) async {
    try {
      final response = await _httpConnectionsService.post('parkings', {},
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200 && jsonDecode(response.body).isNotEmpty) {
        return jsonDecode(response.body)['status']
            .toString()
            .contains('success');
      }
      return false;
    } catch (e) {
      throw EstacionamentoFailure(e.toString());
    }
  }

  @override
  Future<List<EstacionamentoEntity>> getEstacionamentos(
      {required String token}) async {
    try {
      final response = await _httpConnectionsService.get('parkings?filter',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token'
          });
      if (response.statusCode == 200 && jsonDecode(response.body).isNotEmpty) {
        return (jsonDecode(response.body) as List<dynamic>)
            .map((e) => EstacionamentoDto.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw EstacionamentoFailure(e.toString());
    }
  }
}
