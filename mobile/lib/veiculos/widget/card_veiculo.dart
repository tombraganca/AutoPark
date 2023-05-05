import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:flutter/material.dart';

class CardVeiculo extends StatelessWidget {
  final VehicleEntity vehicleEntity;
  const CardVeiculo({super.key, required this.vehicleEntity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      child: SizedBox(
        height: 90,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  vehicleEntity.modelo,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Marca: ${vehicleEntity.marca}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Placa: ${vehicleEntity.placa}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
