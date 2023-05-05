// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';

class UserEntity {
  String name;
  String phoneNumber;
  List<VehicleEntity> vehicleEntity;
  String token;
  RefreshToken refreshToken;
  UserEntity({
    required this.phoneNumber,
    required this.name,
    required this.vehicleEntity,
    required this.token,
    required this.refreshToken,
  });
  setToken(String token) => this.token = token;
}

class RefreshToken {
  String id;
  int expires;
  String accountId;
  RefreshToken({
    required this.id,
    required this.expires,
    required this.accountId,
  });
}
