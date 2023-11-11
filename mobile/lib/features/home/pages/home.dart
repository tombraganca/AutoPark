import 'package:auto_park/features/home/cubit/home_cubit.dart';
import 'package:auto_park/features/home/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  final Future<dynamic> Function()? showDialogAcesso;
  final HomeCubit homeCubit;
  const Home({
    super.key,
    required this.homeCubit,
    this.showDialogAcesso,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    widget.homeCubit
      ..setIndexInit(0)
      ..getPermissionNotification();
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
      drawer: Drawer(
        child: Column(
          children: [
            Container(
                child: const DrawerHeader(
              child: null,
            ))
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
        title: BlocBuilder<HomeCubit, HomeState>(
          bloc: widget.homeCubit,
          builder: (context, state) {
            return Text(
              state.titleContentCurrentWidget,
            );
          },
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
          bloc: widget.homeCubit,
          builder: (context, state) {
            return state.contentCurrentWidget;
          }),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        bloc: widget.homeCubit,
        builder: (context, state) {
          return BottomNavigationBar(
            currentIndex: state.indexCurrentContentHome,
            selectedFontSize: 12,
            unselectedFontSize: 8,
            selectedItemColor: Theme.of(context).colorScheme.primary,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            items: const [
              BottomNavigationBarItem(
                  label: 'Estacionamentos', icon: Icon(Icons.local_parking)),
              BottomNavigationBarItem(
                  label: 'Registros', icon: Icon(Icons.history)),
              BottomNavigationBarItem(
                  label: 'Veículos', icon: Icon(LineIcons.car)),
              BottomNavigationBarItem(
                  label: 'Pagamentos',
                  icon: Icon(Icons.monetization_on_outlined))
            ],
            onTap: (int index) => widget.homeCubit.changeContentHome(index),
          );
        },
      ),
    );
  }
}
