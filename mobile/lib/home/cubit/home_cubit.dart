import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:auto_park/home/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectList { hoje, ultimaSemana, todos }

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
            statusHome: StatusHome.initial, selectList: SelectList.hoje));
  void init() {
    emit(state.copyWith(
        listRegistros: mapListMock[SelectList.hoje],
        statusHome: StatusHome.loadingList));
    emit(state.copyWith(statusHome: StatusHome.loadedList));
  }

  void changeList(SelectList selectList) => emit(state.copyWith(
      selectList: selectList,
      listRegistros: mapListMock[selectList],
      statusHome: state.statusHome == StatusHome.loadedList
          ? StatusHome.refrashLoadedList
          : StatusHome.loadedList));
}

Map<SelectList, List<RegistroEntity>> mapListMock = {
  SelectList.hoje: [
    RegistroEntity(
      date: '10/03/2023',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '10/03/2023',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '10/03/2023',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
  ],
  SelectList.todos: [
    RegistroEntity(
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '12/06/2024',
      registro: 'Registrada em 8:00',
      title: 'Entrada',
    ),
  ],
  SelectList.ultimaSemana: [
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
    RegistroEntity(
      date: '23/04/2025',
      registro: 'Registrada em 11:00',
      title: 'Entrada',
    ),
  ]
};
