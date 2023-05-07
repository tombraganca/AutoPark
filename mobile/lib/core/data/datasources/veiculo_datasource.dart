import 'dart:convert';

import 'package:auto_park/core/data/dtos/vehicle_dto.dart';
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/core/failures/veiculos/veiculo_failure.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class VehicleDataSource {
  Future<List<VehicleEntity>> getVehicle(String token);
  Future<bool> deleteVehicle(String token);
  Future<bool> addVehicle(
      String marca, String modelo, String placa, String token);
}

class VehicleDataSourceImp implements VehicleDataSource {
  final HttpConnectionsService _httpConnectionsService;
  VehicleDataSourceImp(this._httpConnectionsService);
  @override
  Future<bool> addVehicle(
      String marca, String modelo, String placa, String token) async {
    try {
      Response response = await _httpConnectionsService.post(
        'car',
        {'manufacturer': marca, 'model': modelo, 'plate': placa},
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['ownerId']!.isNotEmpty;
      }
      return false;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<bool> deleteVehicle(String token) {
    // TODO: implement deleteVehicles
    throw UnimplementedError();
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
