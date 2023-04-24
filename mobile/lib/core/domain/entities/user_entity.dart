import 'package:auto_park/core/domain/entities/vehicle_entity.dart';

class UserEntity {
  final String name;
  final String phoneNumber;
  final List<VehicleEntity> vehicleEntity;
  UserEntity({
    required this.phoneNumber,
    required this.name,
    required this.vehicleEntity,
  });
}
