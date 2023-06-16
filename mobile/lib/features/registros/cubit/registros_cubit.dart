import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/domain/usecases/registros_usecase.dart';
import 'package:auto_park/features/registros/cubit/registros_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RegistrosCubit extends Cubit<RegistrosState> {
  UserEntity? userEntity;
  RegistrosUseCase registrosUseCase;
  RegistrosCubit({required this.registrosUseCase})
      : super(const RegistrosState(
            statusRegistros: StatusRegistros.initial,
            selectList: SelectList.hoje));

  void setUser(UserEntity userEntity) => this.userEntity = userEntity;

  Future<void> gerRegistros() async {
    emit(state.copyWith(statusRegistros: StatusRegistros.loadingList));
    var result = await registrosUseCase.getRegistros();
    result.fold((left) {
      emit(state.copyWith(statusRegistros: StatusRegistros.failureLoadList));
    }, (listRegistros) {
      Map<SelectList, List<RegistroEntity>> map = {
        SelectList.hoje: [],
        SelectList.todos: [],
        SelectList.ultimaSemana: [],
      };
      for (var registro in listRegistros) {
        final date = DateFormat('yyyy-MM-dd').parse(registro.date);
        if (date.day == DateTime.now().toUtc().day) {
          map[SelectList.hoje]!.add(registro);
        }
        if (date.isBefore(DateTime.now()) &&
            date.isAfter(date.subtract(const Duration(days: 7)))) {
          map[SelectList.ultimaSemana]!.add(registro);
        }
        map[SelectList.todos]!.add(registro);
        emit(state.copyWith(
            mapRegistros: map,
            listRegistros: state.mapRegistros[SelectList.hoje],
            statusRegistros: StatusRegistros.loadedList));
      }
    });
  }

  void changeList(SelectList selectList) => emit(state.copyWith(
      selectList: selectList,
      listRegistros: state.mapRegistros[selectList],
      statusRegistros: state.statusRegistros == StatusRegistros.loadedList
          ? StatusRegistros.refrashLoadedList
          : StatusRegistros.loadedList));
}
