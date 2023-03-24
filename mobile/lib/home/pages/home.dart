import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:auto_park/home/cubit/home_cubit.dart';
import 'package:auto_park/home/cubit/home_state.dart';
import 'package:auto_park/home/pages/registros_page.dart';
import 'package:auto_park/home/widgets/selector_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/items_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> listItemsDrawer = [
    'Meus Registros',
    'Vagas Disponíveis',
    'Meus Veículos',
  ];

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = BlocProvider.of<HomeCubit>(context);
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
                      return ItemsDrawer(
                        label: listItemsDrawer[index],
                        onPressed: () {},
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ItemsDrawer(
                        label: 'Minha Conta',
                        onPressed: () {},
                      ),
                    ),
                    const Icon(Icons.person)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text(
          'Registros',
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        builder: (context, state) {
          if (state.statusHome == StatusHome.initial) {
            homeCubit.init();
          }
          return Column(
            children: [
              SelectorPage(
                homeCubit: homeCubit,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.77,
                child: Visibility(
                  visible: state.statusHome != StatusHome.loadingList,
                  replacement: Column(children: const [
                    CircularProgressIndicator(),
                    Text('Carregando a lista...')
                  ]),
                  child: RegistrosPage(
                    listaRegistros: state.listRegistros!,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
