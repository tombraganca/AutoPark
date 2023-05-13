// ignore_for_file: must_be_immutable

import 'package:auto_park/core/data/dtos/notification_dto.dart';
import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/core/rotas/routes_app.dart';
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
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: DrawerHeader(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.directions_car_rounded,
                          color: Colors.purple,
                        ),
                        Text('Auto Park')
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
                height: 3,
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context)
                        .popUntil((route) => route.isFirst),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              'Sair',
                              style: TextStyle(fontSize: 22),
                            ),
                          ),
                          Icon(Icons.exit_to_app)
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
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
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushReplacementNamed(
              'NOTIFICACAO',
              arguments: NotificationDto(
                  id: '1',
                  title: 'title',
                  body: 'body',
                  vehicleEntity: VehicleEntity(
                      id: '1',
                      marca: 'Toyota',
                      modelo: 'Corrola',
                      placa: 'BBA1234'),
                  datahora: '2023/05/12',
                  tipoDeAcesso: 'Entrada'),
            ),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
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
                  label: 'Veículos', icon: Icon(LineIcons.car))
            ],
            onTap: (int index) => homeCubit.changeContentHome(index),
          );
        },
      ),
    );
  }
}
