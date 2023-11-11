import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/features/estacionamentos/cubit/estacionamento_cubit.dart';
import 'package:auto_park/features/estacionamentos/pages/estacionamentos.dart';
import 'package:auto_park/features/home/cubit/home_state.dart';
import 'package:auto_park/features/pagamentos/cubit/pagamentos_cubit.dart';
import 'package:auto_park/features/pagamentos/pages/pagamentos.dart';
import 'package:auto_park/features/registros/cubit/registros_cubit.dart';
import 'package:auto_park/features/registros/pages/registros_page.dart';
import 'package:auto_park/features/vagas/cubit/vagas_cubit.dart';
import 'package:auto_park/features/veiculos/cubit/veiculos_cubit.dart';
import 'package:auto_park/features/veiculos/pages/veiculos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeCubit extends Cubit<HomeState> {
  UserEntity userEntity = GetIt.I.get<UserDtoGlobal>().getUser();
  final RegistrosCubit registrosCubit;
  final VagasCubit vagasCubit;
  final VeiculosCubit veiculosCubit;
  final PagamentosCubit pagamentosCubit;
  final EstacionamentoCubit estacionamentoCubit;
  HomeCubit({
    required this.registrosCubit,
    required this.vagasCubit,
    required this.veiculosCubit,
    required this.pagamentosCubit,
    required this.estacionamentoCubit,
  }) : super(const HomeState(statusHome: StatusHome.initial));
  void changeContentHome(int index) {
    emit(state.copyWith(
        indexCurrentContentHome: index,
        contentCurrentWidget: contentsHome(index),
        titleContentCurrentWidget: currentTitleWidget(index)));
  }

  void setIndexInit(int index) => emit(state.copyWith(
      indexCurrentContentHome: index,
      contentCurrentWidget: contentsHome(index),
      titleContentCurrentWidget: currentTitleWidget(index)));

  Future<void> getPermissionNotification() async {
    PermissionStatus permissionStatus = await Permission.notification.request();
    if (permissionStatus.isDenied || permissionStatus.isPermanentlyDenied) {
      Fluttertoast.showToast(msg: 'Habilite as notificações !! ');
      openAppSettings();
    }
  }

  void getUser() => userEntity = GetIt.I.get<UserDtoGlobal>().getUser();
  Widget contentsHome(int index) {
    Map<int, Widget> mapContents = {
      0: Estacionamentos(
        estacionamentoCubit: estacionamentoCubit,
      ),
      1: RegistrosPage(
        registrosCubit: registrosCubit,
      ),
      2: Veiculos(
        veiculosCubit: veiculosCubit,
      ),
      3: Pagamentos(pagamentosCubit: pagamentosCubit)
    };
    return mapContents[index] ??
        Estacionamentos(
          estacionamentoCubit: estacionamentoCubit,
        );
  }

  String currentTitleWidget(int index) {
    Map<int, String> mapTitles = {
      0: 'Estacionamentos',
      1: 'Registros',
      2: 'Veículos',
      3: 'Pagamentos',
    };
    return mapTitles[index] ?? 'Estacionamentos';
  }
}
