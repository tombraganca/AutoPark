import 'package:auto_park/core/domain/entities/estacionamento_entity.dart';
import 'package:auto_park/features/notificacao/widgets/custom_text.dart';
import 'package:auto_park/packages/open_url.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CardEstacionamento extends StatelessWidget {
  final EstacionamentoEntity estacionamentoEntity;
  const CardEstacionamento({
    super.key,
    required this.estacionamentoEntity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, 'VAGAS',
          arguments: estacionamentoEntity.parkingId),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
        child: Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    estacionamentoEntity.nomeEstacionamento,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: CustomText(
                  value:
                      "${estacionamentoEntity.localizacaoEntity.latitude} \n ${estacionamentoEntity.localizacaoEntity.longiture}",
                  label: 'Localização: ',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    height: 70,
                    child: IconButton(
                      onPressed: () => OpenUrl.openWaze(
                          estacionamentoEntity.localizacaoEntity.latitude,
                          estacionamentoEntity.localizacaoEntity.longiture,
                          estacionamentoEntity.nomeEstacionamento),
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LineIcons.waze),
                          Text('Waze'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    height: 70,
                    child: IconButton(
                      onPressed: () => OpenUrl.openMaps(
                          estacionamentoEntity.localizacaoEntity.latitude,
                          estacionamentoEntity.localizacaoEntity.longiture,
                          estacionamentoEntity.nomeEstacionamento),
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LineIcons.mapMarked),
                          Text('Google Maps')
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
