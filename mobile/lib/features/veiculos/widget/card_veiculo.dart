import 'package:auto_park/core/domain/entities/vehicle_entity.dart';
import 'package:auto_park/features/veiculos/cubit/veiculos_cubit.dart';
import 'package:auto_park/features/veiculos/widget/dialog_cadastro_veiculo.dart';
import 'package:flutter/material.dart';

class CardVeiculo extends StatelessWidget {
  final VehicleEntity vehicleEntity;
  final VeiculosCubit veiculosCubit;
  const CardVeiculo({
    super.key,
    required this.vehicleEntity,
    required this.veiculosCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      child: SizedBox(
        height: 120,
        child: Card(
          elevation: 20,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.65,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Text(
                          vehicleEntity.modelo,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Text(
                          'Marca: ${vehicleEntity.marca}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16, bottom: 10),
                        child: Text('Placa: ${vehicleEntity.placa}'),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.1,
                  child: IconButton(
                    onPressed: () => DialogCadastroVeiculo(
                      isUpdate: true,
                      context: context,
                      modelo: vehicleEntity.modelo,
                      marca: vehicleEntity.marca,
                      placa: vehicleEntity.placa,
                      veiculosCubit: veiculosCubit,
                    ),
                    icon: const Icon(
                      Icons.edit,
                      color: Color.fromARGB(255, 208, 188, 255),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
