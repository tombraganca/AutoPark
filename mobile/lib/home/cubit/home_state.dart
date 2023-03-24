// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:auto_park/home/cubit/home_cubit.dart';

enum StatusHome { loadingList, loadedList, initial, refrashLoadedList }

class HomeState {
  final List<RegistroEntity>? listRegistros;
  final StatusHome statusHome;
  final SelectList selectList;

  HomeState({
    required this.statusHome,
    this.listRegistros = const [],
    required this.selectList,
  });

  HomeState copyWith({
    List<RegistroEntity>? listRegistros,
    StatusHome? statusHome,
    SelectList? selectList,
  }) {
    return HomeState(
      listRegistros: listRegistros ?? this.listRegistros,
      statusHome: statusHome ?? this.statusHome,
      selectList: selectList ?? this.selectList,
    );
  }
}
