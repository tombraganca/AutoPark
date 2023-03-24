import 'package:auto_park/core/domain/entities/registros_entity.dart';
import 'package:auto_park/home/widgets/cards_registros.dart';
import 'package:flutter/material.dart';

class RegistrosPage extends StatelessWidget {
  final List<RegistroEntity> listaRegistros;
  const RegistrosPage({super.key, required this.listaRegistros});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.separated(
          itemBuilder: (context, index) {
            return CardRegistros(
                title: listaRegistros[index].title,
                registro: listaRegistros[index].registro,
                date: listaRegistros[index].date);
          },
          separatorBuilder: (context, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Divider(
                color: Colors.white,
                height: 5,
              ),
            );
          },
          itemCount: listaRegistros.length),
    );
  }
}
