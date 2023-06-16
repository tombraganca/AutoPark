import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:equatable/equatable.dart';

class RegistrosState extends Equatable {
  final List<RegistroEntity> listRegistros;
  final StatusRegistros statusRegistros;
  final SelectList selectList;
  final Map<SelectList, List<RegistroEntity>> mapRegistros;
  const RegistrosState(
      {required this.statusRegistros,
      this.listRegistros = const [],
      required this.selectList,
      this.mapRegistros = const {
        SelectList.hoje: [],
        SelectList.todos: [],
        SelectList.ultimaSemana: [],
      }});

  RegistrosState copyWith({
    List<RegistroEntity>? listRegistros,
    StatusRegistros? statusRegistros,
    SelectList? selectList,
    Map<SelectList, List<RegistroEntity>>? mapRegistros,
  }) {
    return RegistrosState(
      listRegistros: listRegistros ?? this.listRegistros,
      statusRegistros: statusRegistros ?? this.statusRegistros,
      mapRegistros: mapRegistros ?? this.mapRegistros,
      selectList: selectList ?? this.selectList,
    );
  }

  @override
  List<Object?> get props =>
      [listRegistros, statusRegistros, selectList, mapRegistros];
}

enum StatusRegistros {
  loadingList,
  loadedList,
  initial,
  refrashLoadedList,
  failureLoadList
}

enum SelectList { hoje, ultimaSemana, todos }
