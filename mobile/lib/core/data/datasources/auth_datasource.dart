import 'dart:convert';
import 'package:auto_park/core/data/dtos/user_dto.dart';
import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/failures/auth/auth_failure.dart';
import 'package:auto_park/core/services/http_connections_service.dart';
import 'package:http/http.dart';

abstract class AuthDataSource {
  Future<UserEntity> auth(String email, String password);
  Future<bool> create(String email, String password);
  Future<bool> delete(String email, String password);
}

class AuthDataSourceImp implements AuthDataSource {
  final HttpConnectionsService _httpConnectionsService;
  AuthDataSourceImp(this._httpConnectionsService);
  @override
  Future<UserEntity> auth(String email, String password) async {
    try {
      Response response = await _httpConnectionsService
          .post('auth', {'login': email, 'senha': password});
      if (response.statusCode == 200) {
        return UserDto.fromJson(jsonDecode(response.body));
      } else {
        throw AuthFailure('Error ao logar');
      }
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<bool> create(String email, String password) async {
    try {
      Response response = await _httpConnectionsService
          .post('auth', {'login': email, 'senha': password});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<bool> delete(String email, String password) async {
    try {
      Response response = await _httpConnectionsService
          .delete('auth', {'login': email, 'senha': password});
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }
}
