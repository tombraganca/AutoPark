import 'package:auto_park/features/estacionamentos/cubit/estacionamento_cubit.dart';
import 'package:auto_park/features/estacionamentos/cubit/estacionamento_state.dart';
import 'package:auto_park/features/estacionamentos/widgets/card_estacionamento.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Estacionamentos extends StatefulWidget {
  final EstacionamentoCubit estacionamentoCubit;

  const Estacionamentos({
    super.key,
    required this.estacionamentoCubit,
  });

  @override
  State<Estacionamentos> createState() => _EstacionamentosState();
}

class _EstacionamentosState extends State<Estacionamentos> {
  @override
  void initState() {
    widget.estacionamentoCubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      body: BlocBuilder<EstacionamentoCubit, EstacionamentoState>(
          bloc: widget.estacionamentoCubit,
          builder: (context, state) {
            return Column(
              children: [
                Visibility(
                  visible: state.statusEstacionamento ==
                      StatusEstacionamento.buscandoEstacionamentos,
                  replacement: SizedBox(
                    height: availableHeight * 0.80,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: state.listEstacionamentos.length,
                      itemBuilder: (context, index) {
                        return CardEstacionamento(
                            estacionamentoEntity:
                                state.listEstacionamentos[index]);
                      },
                    ),
                  ),
                  child: SizedBox(
                    height: availableHeight * 0.8,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('Carregando as vagas...'),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
