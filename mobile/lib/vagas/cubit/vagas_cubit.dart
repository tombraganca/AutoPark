import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:auto_park/vagas/cubit/vagas_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectListVagas { disponivel, todas }

class VagasCubit extends Cubit<VagasState> {
  VagasCubit() : super(const VagasState(statusVagas: StatusVagas.initial));

  void changeList(SelectListVagas selectListVagas) => emit(state.copyWith(
      selectListVagas: selectListVagas,
      listVagas: mapListMock[selectListVagas],
      statusVagas: state.statusVagas == StatusVagas.loadedList
          ? StatusVagas.refrashLoadedList
          : StatusVagas.loadedList));
}

Map<SelectListVagas, List<VagaEntity>> mapListMock = {
  SelectListVagas.disponivel: [
    VagaEntity(
      description: 'Vaga localizada na parte esquerda do primeiro andar',
      name: 'A1',
      reportes: [
        'Existe um saco de batatas no local da vaga que impossibilita o uso da vaga',
        'Um motorista acefalóide parou o carro em duas vagas impossibilitando o uso da vaga',
        ''
      ],
    ),
    VagaEntity(
      description: 'Vaga localizada na parte direita do primeiro andar',
      name: 'A2',
      reportes: [
        'Existe um saco de batatas no local da vaga que impossibilita o uso da vaga',
        'Um motorista acefalóide parou o carro em duas vagas impossibilitando o uso da vaga',
        ''
      ],
    )
  ],
  SelectListVagas.todas: [
    VagaEntity(
      description: 'Vaga localizada na parte esquerda do primeiro andar',
      name: 'A1',
      reportes: [
        'Existe um saco de batatas no local da vaga que impossibilita o uso da vaga',
        'Um motorista acefalóide parou o carro em duas vagas impossibilitando o uso da vaga',
        ''
      ],
    ),
    VagaEntity(
      description: 'Vaga localizada na parte direita do primeiro andar',
      name: 'A2',
      reportes: [
        'Existe um saco de batatas no local da vaga que impossibilita o uso da vaga',
        'Um motorista acefalóide parou o carro em duas vagas impossibilitando o uso da vaga',
        ''
      ],
    )
  ],
};
