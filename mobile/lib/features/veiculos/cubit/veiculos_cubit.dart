import 'package:auto_park/core/data/dtos/vehicle_dto.dart';
import 'package:auto_park/core/domain/usecases/veiculo_usecase.dart';
import 'package:auto_park/core/functions/toasts.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/features/veiculos/cubit/veiculos_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class VeiculosCubit extends Cubit<VeiculosState> with ToastMessages {
  final VehicleUseCase vehicleUseCase;
  VeiculosCubit({required this.vehicleUseCase})
      : super(const VeiculosState(statusVeiculos: StatusVeiculos.initial));

  Future<void> getVeiculos() async {
    emit(state.copyWith(statusVeiculos: StatusVeiculos.carregando));
    var result = await vehicleUseCase
        .getVehicles(GetIt.I.get<UserDtoGlobal>().getUser().token);
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
        marca, modelo, placa, GetIt.I.get<UserDtoGlobal>().getUser().token);
    result.fold((left) {
      emit(state.copyWith(
          erroMsg: left.msg.contains('exists')
              ? 'Este veículo ja foi cadastrado.'
              : 'Não foi possível realizar cadastro.',
          statusVeiculos: StatusVeiculos.errorAddVeiculo));
    }, (succes) {
      emit(state.copyWith(
          statusVeiculos: StatusVeiculos.reloadListVechicles,
          listVehicles: state.listVehicles
              .followedBy([
                VehicleDto(id: '', marca: marca, modelo: modelo, placa: placa)
              ].toList())
              .toList()));
      showMessagePositive('Carro adicionado com sucesso.');
    });
  }

  void reloadList() =>
      emit(state.copyWith(statusVeiculos: StatusVeiculos.initial));
}
