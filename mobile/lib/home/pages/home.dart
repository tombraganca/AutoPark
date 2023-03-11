import 'package:flutter/material.dart';

import '../widgets/cards_registros.dart';
import '../widgets/items_drawer.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final List<String> listItemsDrawer = [
    ' Meus Registros',
    'Vagas Disponíveis',
    'Meus Veículos',
  ];
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ItemsDrawer(
                      label: 'Minha Conta',
                      onPressed: () {},
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
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CardRegitros(
              date: '10/03/2023',
              registro: 'Registrada em 8:00',
              title: 'Entrada',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CardRegitros(
              date: '10/03/2023',
              registro: 'Registrada em 8:00',
              title: 'Entrada',
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CardRegitros(
              date: '10/03/2023',
              registro: 'Registrada em 8:00',
              title: 'Entrada',
            ),
          )
        ],
      ),
    );
  }
}
