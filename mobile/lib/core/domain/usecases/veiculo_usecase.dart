import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/core/domain/repositories/veiculo_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

abstract class VehicleUseCase {
  Future<Either<Failure, List<VehicleEntity>>> getVehicles(String token);
  Future<Either<Failure, bool>> addVehicle(
      isUpdate, String marca, String modelo, String placa, String token);
}

class VehicleUseCaseImp implements VehicleUseCase {
  final VehicleRepository _vehicleRepository;
  VehicleUseCaseImp(this._vehicleRepository);
  @override
  Future<Either<Failure, bool>> addVehicle(
      isUpdate, String marca, String modelo, String placa, String token) async {
    return await _vehicleRepository.addVehicle(
        isUpdate, marca, modelo, placa, token);
  }

  @override
  Future<Either<Failure, List<VehicleEntity>>> getVehicles(String token) async {
    return await _vehicleRepository.getVehicles(token);
  }
}
