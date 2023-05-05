import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:auto_park/registros/cubit/registros_cubit.dart';
import 'package:equatable/equatable.dart';

class RegistrosState extends Equatable {
  final List<RegistroEntity> listRegistros;
  final StatusRegistros statusRegistros;
  final SelectList selectList;

  RegistrosState({
    required this.statusRegistros,
    this.listRegistros = const [],
    required this.selectList,
  });

  RegistrosState copyWith({
    List<RegistroEntity>? listRegistros,
    StatusRegistros? statusRegistros,
    SelectList? selectList,
  }) {
    return RegistrosState(
      listRegistros: listRegistros ?? this.listRegistros,
      statusRegistros: statusRegistros ?? this.statusRegistros,
      selectList: selectList ?? this.selectList,
    );
  }

  @override
  List<Object?> get props => [listRegistros, statusRegistros, selectList];
}

enum StatusRegistros { loadingList, loadedList, initial, refrashLoadedList }
