import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class VehicleRepository {
  Future<Either<Failure, List<VehicleEntity>>> getVehicles(String token);
  Future<Either<Failure, bool>> addVehicle(
      bool isUpdate, String marca, String modelo, String placa, String token);
}
