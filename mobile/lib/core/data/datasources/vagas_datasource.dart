import 'dart:convert';

import 'package:auto_park/core/data/dtos/vaga_dto.dart';
import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class VagasDataSource {
  Future<List<VagaEntity>> getVagas();
}

class VagasDataSourceImp implements VagasDataSource {
  final HttpConnectionsService _httpConnectionsService;
  VagasDataSourceImp(this._httpConnectionsService);
  @override
  Future<List<VagaEntity>> getVagas() async {
    try {
      Response response = await _httpConnectionsService.get('vagas');
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List<dynamic>)
            .map((e) => VagaDto.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw e.toString();
    }
  }
}
