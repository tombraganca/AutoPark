import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';
import 'package:auto_park/core/domain/entities/localizacao_entity.dart';
import 'package:auto_park/features/estacionamentos/cubit/estacionamento_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EstacionamentoCubit extends Cubit<EstacionamentoState> {
  EstacionamentoCubit()
      : super(const EstacionamentoState(
            statusEstacionamento: StatusEstacionamento.initial));

  void init() {
    emit(state.copyWith(listEstacionamentos: [
      EstacionamentoEntity(
        parkingId: 1,
        endereco: '',
        nomeEstacionamento: 'Toninho da borracharia',
        localizacaoEntity: LocalizacaoEntity(latitude: '', longiture: ''),
      )
    ]));
  }
}
