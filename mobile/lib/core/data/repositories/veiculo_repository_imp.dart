import 'package:auto_park/core/data/datasources/veiculo_datasource.dart';
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/core/domain/repositories/veiculo_repository.dart';
import 'package:auto_park/core/failures/failure.dart';
import 'package:either_dart/either.dart';

class VehicleRepositoryImp implements VehicleRepository {
  final VehicleDataSource _vehicleDataSource;
  VehicleRepositoryImp(this._vehicleDataSource);
  @override
  Future<Either<Failure, bool>> addVehicle(
      String marca, String modelo, String placa, String token) async {
    try {
      return Right(
          await _vehicleDataSource.addVehicle(marca, modelo, placa, token));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, bool>> deleteVehicle(String token) async {
    try {
      return Right(await _vehicleDataSource.deleteVehicle(token));
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<VehicleEntity>>> getVehicles(String token) async {
    try {
      return Right(await _vehicleDataSource.getVehicle(token));
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
