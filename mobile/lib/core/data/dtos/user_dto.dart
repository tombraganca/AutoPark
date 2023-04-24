import 'package:auto_park/core/data/dtos/vehicle_dto.dart';
import 'package:auto_park/core/domain/entities/user_entity.dart';

class UserDto extends UserEntity {
  UserDto(
      {required super.phoneNumber,
      required super.name,
      required super.vehicleEntity});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
        phoneNumber: json['phoneNumber'],
        name: json['name'],
        vehicleEntity: json['vehicle'] != null
            ? (json['vehicle'] as List<dynamic>)
                .map((e) => VehicleDto.fromJson(e))
                .toList()
            : []);
  }
  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': super.phoneNumber,
      'name': super.name,
      'vehicle': super.vehicleEntity,
    };
  }
}
