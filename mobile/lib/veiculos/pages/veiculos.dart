import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/veiculos/cubit/veiculos_cubit.dart';
import 'package:auto_park/veiculos/cubit/veiculos_state.dart';
import 'package:auto_park/veiculos/widget/card_veiculo.dart';
import 'package:auto_park/veiculos/widget/dialog_cadastro_veiculo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class Veiculos extends StatefulWidget {
  final UserEntity userEntity;
  const Veiculos({super.key, required this.userEntity});

  @override
  State<Veiculos> createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos> {
  final VeiculosCubit veiculosCubit = GetIt.I.get<VeiculosCubit>();
  @override
  void initState() {
    veiculosCubit.setUser(widget.userEntity);
    veiculosCubit.getVeiculos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.of(context).size.height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<VeiculosCubit, VeiculosState>(
        bloc: veiculosCubit,
        listener: (context, state) {
          if (state.statusVeiculos == StatusVeiculos.reloadListVechicles) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
                height: availableHeight,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: availableHeight * 0.08,
                        child: ElevatedButton(
                            onPressed: () => DialogCadastroVeiculo(
                                context: context, veiculosCubit: veiculosCubit),
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Colors.transparent),
                            ),
                            child: const Text(
                              'Adicionar carro',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: availableHeight * 0.85,
                      child: ListView.separated(
                        itemCount: state.listVehicles.length,
                        itemBuilder: (context, index) {
                          return CardVeiculo(
                              vehicleEntity: state.listVehicles[index]);
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
                      ),
                    ),
                  ],
                )),
          );
        },
      ),
    );
  }
}
