import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:auto_park/core/domain/usecases/vagas_usecase.dart';
import 'package:auto_park/features/vagas/cubit/vagas_state.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SelectListVagas { disponivel, todas }

class VagasCubit extends Cubit<VagasState> {
  final VagasUseCase vagasUseCase;
  UserEntity? userEntity;
  VagasCubit({required this.vagasUseCase})
      : super(const VagasState(statusVagas: StatusVagas.initial));

  void setUser(UserEntity userEntity) => this.userEntity = userEntity;

  void changeList(SelectListVagas selectListVagas) => emit(state.copyWith(
      selectListVagas: selectListVagas,
      listSelected: state.maplistVagas[selectListVagas],
      statusVagas: state.statusVagas == StatusVagas.selectList
          ? StatusVagas.refrashselectList
          : StatusVagas.selectList));

  Future<void> getVagas() async {
    emit(state.copyWith(statusVagas: StatusVagas.buscandoVagas));
    var result = await vagasUseCase.getVagas(userEntity!.token);
    result.fold((left) {
      emit(state.copyWith(statusVagas: StatusVagas.errorBuscarVagas));
    }, (listVagas) {
      emit(state.copyWith(
        statusVagas: StatusVagas.sucessoBuscarVagas,
        maplistVagas: {
          SelectListVagas.disponivel: listVagas
              .where(
                  (element) => element.situacao.toLowerCase().contains('free'))
              .toList(),
          SelectListVagas.todas: listVagas,
        },
      ));
    });
  }
}
