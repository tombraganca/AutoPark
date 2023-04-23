import 'package:auto_park/core/domain/entities/vaga_entity.dart';
import 'package:flutter/material.dart';

class CardVagas extends StatelessWidget {
  final VagaEntity vagaEntity;
  const CardVagas({super.key, required this.vagaEntity});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
        Radius.circular(10),
      )),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: vagaEntity.isAvailable ? Colors.green : Colors.red,
                  width: 10)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(vagaEntity.name),
                  Text(vagaEntity.description),
                ],
              ),
            ),
            Icon(
              vagaEntity.getIconTipoVaga(vagaEntity.tipoVaga),
              size: 32,
            )
          ],
        ),
      ),
    );
  }
}
