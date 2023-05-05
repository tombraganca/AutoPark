import 'package:auto_park/core/data/dtos/vehicle_dto.dart';
import 'package:auto_park/core/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  UserDto(
      {required super.phoneNumber,
      required super.name,
      required super.vehicleEntity,
      required super.token,
      required super.refreshToken});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
        phoneNumber: json['phoneNumber'] ?? '',
        name: json['name'] ?? '',
        token: json['token'] ?? '',
        vehicleEntity: json['vehicle'] != null
            ? (json['vehicle'] as List<dynamic>)
                .map((e) => VehicleDto.fromJson(e))
                .toList()
            : [],
        refreshToken: json['refreshToken'] != null
            ? RefreshTokenDto.fromJson(json['refreshToken'])
            : RefreshTokenDto.empty());
  }
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': super.phoneNumber,
      'name': super.name,
      'vehicle': super.vehicleEntity,
    };
  }

  factory UserDto.empty() {
    return UserDto(
        phoneNumber: '',
        name: '',
        vehicleEntity: [],
        token: '',
        refreshToken: RefreshTokenDto.empty());
  }
}

class RefreshTokenDto extends RefreshToken {
  RefreshTokenDto(
      {required super.id, required super.expires, required super.accountId});

  factory RefreshTokenDto.fromJson(Map<String, dynamic> json) {
    return RefreshTokenDto(
        id: json['id'] ?? '',
        expires: json['expiresIn'] ?? 0,
        accountId: json['accountId'] ?? '');
  }

  factory RefreshTokenDto.empty() {
    return RefreshTokenDto(id: '', expires: 0, accountId: '');
  }
}
