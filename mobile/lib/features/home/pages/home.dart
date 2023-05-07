import 'package:auto_park/features/home/cubit/home_cubit.dart';
import 'package:auto_park/features/home/cubit/home_state.dart';
import 'package:auto_park/features/vagas/pages/vagas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:line_icons/line_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeCubit homeCubit = GetIt.I.get<HomeCubit>();
  final List<String> listItemsDrawer = [
    'Meus Registros',
    'Vagas Disponíveis',
    'Meus Veículos',
  ];

  @override
  void initState() {
    homeCubit.setIndexInit(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: Drawer(
          child: Column(
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
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            if (listItemsDrawer[index]
                                .contains('Vagas Disponíveis')) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Vagas(
                                          userEntity: homeCubit.userEntity)));
                            }
                          },
                          child: Text(
                            listItemsDrawer[index],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: Divider(
                          color: Colors.white,
                          height: 2,
                        ),
                      );
                    },
                    itemCount: listItemsDrawer.length),
              ),
              const Divider(
                color: Colors.white,
                height: 2,
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.of(context).popUntil((route) => route.isFirst),
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
              )
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
            onPressed: () {},
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
