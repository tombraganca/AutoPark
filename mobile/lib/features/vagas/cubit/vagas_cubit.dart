import 'package:auto_park/core/domain/usecases/vagas_usecase.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/features/vagas/cubit/vagas_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

enum SelectListVagas { disponivel, todas, reservadas }

class VagasCubit extends Cubit<VagasState> {
  final VagasUseCase vagasUseCase;
  VagasCubit({required this.vagasUseCase})
      : super(const VagasState(statusVagas: StatusVagas.initial));

  void changeList(SelectListVagas selectListVagas) => emit(state.copyWith(
      selectListVagas: selectListVagas,
      listSelected: state.maplistVagas[selectListVagas],
      statusVagas: state.statusVagas == StatusVagas.selectList
          ? StatusVagas.refrashselectList
          : StatusVagas.selectList));

  Future<void> getVagas({required String parkingId}) async {
    emit(state.copyWith(statusVagas: StatusVagas.buscandoVagas));
    var result = await vagasUseCase.getVagas(
        token: GetIt.I.get<UserDtoGlobal>().getUser().token,
        parkingId: parkingId);
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
        selectListVagas: SelectListVagas.disponivel,
        listSelected: listVagas
            .where((element) => element.situacao.toLowerCase().contains('free'))
            .toList(),
      ));
    });
  }
}
