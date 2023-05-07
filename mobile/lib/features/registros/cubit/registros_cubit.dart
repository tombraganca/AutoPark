import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/features/registros/cubit/registros_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectList { hoje, ultimaSemana, todos }

class RegistrosCubit extends Cubit<RegistrosState> {
  UserEntity? userEntity;
  RegistrosCubit()
      : super(const RegistrosState(
            statusRegistros: StatusRegistros.initial,
            selectList: SelectList.hoje));

  void setUser(UserEntity userEntity) => this.userEntity = userEntity;

  void init() {
    emit(state.copyWith(
        listRegistros: mapListMock[SelectList.hoje],
        statusRegistros: StatusRegistros.loadingList));
    emit(state.copyWith(statusRegistros: StatusRegistros.loadedList));
  }

  void changeList(SelectList selectList) => emit(state.copyWith(
      selectList: selectList,
      listRegistros: mapListMock[selectList],
      statusRegistros: state.statusRegistros == StatusRegistros.loadedList
          ? StatusRegistros.refrashLoadedList
          : StatusRegistros.loadedList));
}

Map<SelectList, List<RegistroEntity>> mapListMock = {
  SelectList.hoje: [
    RegistroEntity(
      date: '10/03/2023',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
      id: 1,
    ),
    RegistroEntity(
      id: 1,
      date: '10/03/2023',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '10/03/2023',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
  ],
  SelectList.todos: [
    RegistroEntity(
      id: 1,
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
  ],
  SelectList.ultimaSemana: [
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      id: 1,
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
  ]
};
