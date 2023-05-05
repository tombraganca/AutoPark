import 'package:auto_park/core/data/dtos/vehicle_dto.dart';
import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/domain/usecases/veiculo_usecase.dart';
import 'package:auto_park/core/functions/toasts.dart';
import 'package:auto_park/veiculos/cubit/veiculos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VeiculosCubit extends Cubit<VeiculosState> with ToastMessages {
  final VehicleUseCase vehicleUseCase;
  UserEntity? userEntity;
  VeiculosCubit({required this.vehicleUseCase})
      : super(const VeiculosState(statusVeiculos: StatusVeiculos.initial));

  void setUser(UserEntity userEntity) => this.userEntity = userEntity;
  Future<void> getVeiculos() async {
    emit(state.copyWith(statusVeiculos: StatusVeiculos.carregando));
    var result = await vehicleUseCase.getVehicles(userEntity!.token);
    result.fold((left) {
      emit(state.copyWith(statusVeiculos: StatusVeiculos.errorBuscarVeiculos));
    }, (listVehicles) {
      emit(state.copyWith(
          statusVeiculos: StatusVeiculos.sucessoVeiculos,
          listVehicles: listVehicles));
    });
  }

  Future<void> addVeiculo(String placa, String marca, String modelo) async {
    emit(state.copyWith(statusVeiculos: StatusVeiculos.adicionandoVeiculo));
    var result = await vehicleUseCase.addVehicle(
        marca, modelo, placa, userEntity!.token);
    result.fold((left) {
      emit(state.copyWith(statusVeiculos: StatusVeiculos.errorAddVeiculo));
    }, (succes) {
      emit(state.copyWith(
          statusVeiculos: StatusVeiculos.reloadListVechicles,
          listVehicles: state.listVehicles
              .followedBy([
                VehicleDto(
                    id: '',
                    name: '',
                    marca: marca,
                    modelo: modelo,
                    placa: placa)
              ].toList())
              .toList()));
      showMessagePositive('Carro adicionado com sucesso.');
    });
  }
}
