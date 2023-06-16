// ignore_for_file: must_be_immutable
import 'package:auto_park/core/data/dtos/notification_dto.dart';
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/features/home/cubit/home_cubit.dart';
import 'package:auto_park/features/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  Future<dynamic> Function()? showDialogAcesso;
  Home({super.key, this.showDialogAcesso});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeCubit homeCubit = GetIt.I.get<HomeCubit>();

  @override
  void initState() {
    homeCubit.setIndexInit(0);
    homeCubit.getPermissionNotification();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showDialogAcesso != null) {
        widget.showDialogAcesso!();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          builder: (context, state) {
            return Text(
              state.titleContentCurrentWidget,
            );
          },
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
          bloc: homeCubit,
          listener: ((context, state) {
            if (state.statusHome == StatusHome.exitApp) {
              Navigator.popAndPushNamed(context, 'LOGIN');
            }
          }),
          builder: (context, state) {
            return state.contentCurrentWidget;
          }),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.indexCurrentContentHome,
            selectedFontSize: 15,
            unselectedFontSize: 9,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                  label: 'Vagas', icon: Icon(Icons.local_parking)),
              BottomNavigationBarItem(
                  label: 'Registros', icon: Icon(Icons.history)),
              BottomNavigationBarItem(
                  label: 'Veículos', icon: Icon(LineIcons.car)),
              BottomNavigationBarItem(
                  label: 'Sair', icon: Icon(Icons.exit_to_app_rounded))
            ],
            onTap: (int index) => homeCubit.changeContentHome(index),
          );
        },
      ),
    );
  }
}
