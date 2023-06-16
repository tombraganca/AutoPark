import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/features/home/cubit/home_state.dart';
import 'package:auto_park/features/registros/pages/registros_page.dart';
import 'package:auto_park/features/vagas/pages/vagas.dart';
import 'package:auto_park/features/veiculos/pages/veiculos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeCubit extends Cubit<HomeState> {
  UserEntity userEntity = GetIt.I.get<UserDtoGlobal>().getUser();
  HomeCubit() : super(const HomeState(statusHome: StatusHome.initial));
  void changeContentHome(int index) {
    if (index == 3) {
      emit(state.copyWith(statusHome: StatusHome.exitApp));
    } else {
      emit(state.copyWith(
          indexCurrentContentHome: index,
          contentCurrentWidget: contentsHome(index),
          titleContentCurrentWidget: currentTitleWidget(index)));
    }
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

  void setUser(UserEntity userEntity) => this.userEntity = userEntity;
  Widget contentsHome(int index) {
    Map<int, Widget> mapContents = {
      0: Vagas(userEntity: userEntity),
      1: RegistrosPage(userEntity: userEntity),
      2: Veiculos(userEntity: userEntity),
    };
    return mapContents[index] ?? Vagas(userEntity: userEntity);
  }

  String currentTitleWidget(int index) {
    Map<int, String> mapTitles = {
      0: 'Vagas',
      1: 'Registros',
      2: 'Veiculos',
    };
    return mapTitles[index] ?? 'Vagas';
  }
}
