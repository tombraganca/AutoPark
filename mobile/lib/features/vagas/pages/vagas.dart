import 'package:auto_park/features/vagas/cubit/vagas_cubit.dart';
import 'package:auto_park/features/vagas/cubit/vagas_state.dart';
import 'package:auto_park/features/vagas/widget/selector_page_vagas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_park/features/vagas/widget/card_vagas.dart';

class Vagas extends StatefulWidget {
  final VagasCubit vagasCubit;
  final String parkingId;
  const Vagas({
    super.key,
    required this.vagasCubit,
    required this.parkingId,
  });

  @override
  State<Vagas> createState() => _VagasState();
}

class _VagasState extends State<Vagas> {
  @override
  void initState() {
    widget.vagasCubit.getVagas(parkingId: widget.parkingId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Vagas'),
      ),
      body: BlocBuilder<VagasCubit, VagasState>(
          bloc: widget.vagasCubit,
          builder: (context, state) {
            return Column(
              children: [
                SizedBox(
                  height: availableHeight * 0.12,
                  child: SelectorVagas(
                    vagasCubit: widget.vagasCubit,
                  ),
                ),
                Visibility(
                  visible: state.statusVagas == StatusVagas.buscandoVagas,
                  replacement: SizedBox(
                    height: availableHeight * 0.95,
                    child: RefreshIndicator(
                      onRefresh: () => widget.vagasCubit
                          .getVagas(parkingId: widget.parkingId),
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemCount: state.listSelected.length,
                        itemBuilder: (context, index) {
                          return CardVagas(
                              vagaEntity: state.listSelected[index]);
                        },
                      ),
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
