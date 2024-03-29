import 'dart:convert';

import 'package:auto_park/core/data/dtos/vehicle_dto.dart';
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/core/failures/veiculos/veiculo_failure.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class VehicleDataSource {
  Future<List<VehicleEntity>> getVehicle(String token);
  Future<bool> addVehicle(
      bool isUpdate, String marca, String modelo, String placa, String token);
}

class VehicleDataSourceImp implements VehicleDataSource {
  final HttpConnectionsService _httpConnectionsService;
  VehicleDataSourceImp(this._httpConnectionsService);
  @override
  Future<bool> addVehicle(bool isUpdate, String marca, String modelo,
      String placa, String token) async {
    try {
      final postData = {'manufacturer': marca, 'model': modelo, 'plate': placa};
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      final response = isUpdate
          ? await _httpConnectionsService.put('car', postData, headers: headers)
          : await _httpConnectionsService.post('car', postData,
              headers: headers);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['ownerId'] != null) return true;
        if (body['status'] != null) throw VeiculosFailure(body['message']);
      }
      return false;
    } catch (e) {
      throw VeiculosFailure(e.toString());
    }
  }

  @override
  Future<List<VehicleEntity>> getVehicle(String token) async {
    try {
      Response response = await _httpConnectionsService.get('car', headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode == 200 && jsonDecode(response.body).isNotEmpty) {
        return (jsonDecode(response.body) as List<dynamic>)
            .map((e) => VehicleDto.fromJson(e))
            .toList();
      }
      return [];
    } catch (e) {
      throw VeiculosFailure(e.toString());
    }
  }
}
