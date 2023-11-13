import 'package:auto_park/features/veiculos/cubit/veiculos_cubit.dart';
import 'package:auto_park/features/veiculos/cubit/veiculos_state.dart';
import 'package:auto_park/features/veiculos/widget/card_veiculo.dart';
import 'package:auto_park/features/veiculos/widget/dialog_cadastro_veiculo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Veiculos extends StatefulWidget {
  final VeiculosCubit veiculosCubit;
  const Veiculos({
    super.key,
    required this.veiculosCubit,
  });

  @override
  State<Veiculos> createState() => _VeiculosState();
}

class _VeiculosState extends State<Veiculos> {
  @override
  void initState() {
    widget.veiculosCubit.getVeiculos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<VeiculosCubit, VeiculosState>(
        bloc: widget.veiculosCubit,
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
                        width: MediaQuery.sizeOf(context).width * 0.95,
                        height: availableHeight * 0.08,
                        child: ElevatedButton(
                            onPressed: () => DialogCadastroVeiculo(
                                context: context,
                                veiculosCubit: widget.veiculosCubit),
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll<Color>(
                                  Theme.of(context).colorScheme.secondary),
                            ),
                            child: const Text(
                              'Adicionar veículo',
                              style: TextStyle(
                                  color: Colors.black,
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
                            vehicleEntity: state.listVehicles[index],
                            veiculosCubit: widget.veiculosCubit,
                          );
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
