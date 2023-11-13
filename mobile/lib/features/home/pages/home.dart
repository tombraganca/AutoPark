import 'package:auto_park/features/home/cubit/home_cubit.dart';
import 'package:auto_park/features/home/cubit/home_state.dart';
import 'package:auto_park/features/minha_conta/widgets/custom_button.dart';
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
    final availableHeight = MediaQuery.sizeOf(context).height -
        (MediaQuery.of(context).padding.top);
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: availableHeight * 0.3,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: Column(
                  children: [
                    Center(
                        child: Image.asset(
                      'assets/images/default_user.png',
                      width: MediaQuery.sizeOf(context).width * 0.2,
                      height: MediaQuery.sizeOf(context).height * 0.2,
                    )),
                    const Text('Toninho da Borracharia')
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.white,
              height: 10,
            ),
            SizedBox(
              height: availableHeight * 0.6,
              child: Column(
                children: [
                  CustomButton(
                      onPressed: () => Navigator.pushNamed(
                            context,
                            'MINHA_CONTA',
                          ),
                      label: 'Minha Conta'),
                  CustomButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, 'DADOS_BANCARIOS'),
                      label: 'Dados Bancários'),
                ],
              ),
            ),
            const Divider(
              color: Colors.white,
              height: 10,
            ),
            SizedBox(
              height: availableHeight * 0.1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Sair',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, 'LOGIN', (route) => false),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, 'MINHA_CONTA'),
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
