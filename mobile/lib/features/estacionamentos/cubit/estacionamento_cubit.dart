import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';
import 'package:auto_park/core/domain/usecases/estacionamento_usecase.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/features/estacionamentos/cubit/estacionamento_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class EstacionamentoCubit extends Cubit<EstacionamentoState> {
  final EstacionamentoUseCase estacionamentoUseCase;
  List<EstacionamentoEntity> listAllEstacionamentos = [];
  EstacionamentoCubit({
    required this.estacionamentoUseCase,
  }) : super(const EstacionamentoState(
            statusEstacionamento: StatusEstacionamento.initial));

  Future<void> getEstacionamentos() async {
    emit(state.copyWith(
        statusEstacionamento: StatusEstacionamento.buscandoEstacionamentos));
    var result = await estacionamentoUseCase.getEstacionamentos(
        token: GetIt.I.get<UserDtoGlobal>().getToken());

    result.fold((failure) {
      emit(state.copyWith(
          statusEstacionamento:
              StatusEstacionamento.failureGetListEstacionamentos));
    }, (estacionamentos) {
      listAllEstacionamentos = estacionamentos;
      emit(state.copyWith(
          listEstacionamentos: estacionamentos,
          statusEstacionamento:
              StatusEstacionamento.loadedListEstacionamentos));
    });
  }

  void filterEstacionamentos(String value) {
    emit(state.copyWith(
        listEstacionamentos: listAllEstacionamentos
            .where((est) => est.nomeEstacionamento
                .toLowerCase()
                .contains(value.toLowerCase()))
            .toList()));
  }

  void clearFilter() {
    emit(state.copyWith(listEstacionamentos: listAllEstacionamentos));
  }
}
