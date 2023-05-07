import 'dart:convert';

import 'package:auto_park/core/data/dtos/user_dto.dart';
import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/failures/auth/auth_failure.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class AuthDataSource {
  Future<UserDto> auth(String email, String password);
  Future<bool> create(String email, String password, String name);
  Future<bool> delete();
}

class AuthDataSourceImp implements AuthDataSource {
  final HttpConnectionsService _httpConnectionsService;
  AuthDataSourceImp(this._httpConnectionsService);
  @override
  Future<UserDto> auth(String email, String password) async {
    try {
      Response response = await _httpConnectionsService
          .post('login', {'email': email, 'password': password});
      if (response.statusCode == 200) {
        return UserDto.fromJson(jsonDecode(response.body));
      } else {
        throw AuthFailure('Falha ao realizar o login !!');
      }
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<bool> create(String email, String password, String name) async {
    try {
      Response response = await _httpConnectionsService
          .post('signup', {'email': email, 'password': password, 'name': name});
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['id'].isNotEmpty;
      } else {
        throw AuthFailure('Falha ao realizar o login !!');
      }
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<bool> delete() async {
    try {
      return false;
      //   return await _httpConnectionsService.delete();
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }
}
