import 'package:auto_park/features/common/widget/search_filter.dart';
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
  final searchController = TextEditingController();
  @override
  void initState() {
    widget.estacionamentoCubit.getEstacionamentos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: BlocBuilder<EstacionamentoCubit, EstacionamentoState>(
              bloc: widget.estacionamentoCubit,
              builder: (context, state) {
                return Visibility(
                  visible: state.statusEstacionamento ==
                      StatusEstacionamento.buscandoEstacionamentos,
                  replacement: Column(
                    children: [
                      SizedBox(
                        height: availableHeight * 0.1,
                        width: MediaQuery.sizeOf(context).width * 0.95,
                        child: Center(
                          child: SearchFilterComponent(
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            onChange: (value) {
                              if (value != null &&
                                  value.isNotEmpty &&
                                  value.length > 3) {
                                widget.estacionamentoCubit
                                    .filterEstacionamentos(value);
                              } else {
                                widget.estacionamentoCubit.clearFilter();
                              }
                            },
                            controller: searchController,
                            onPressed: () {
                              widget.estacionamentoCubit.clearFilter();
                              searchController.clear();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: availableHeight * 0.9,
                        child: RefreshIndicator(
                          onRefresh: () =>
                              widget.estacionamentoCubit.getEstacionamentos(),
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            itemCount: state.listEstacionamentos.length,
                            itemBuilder: (context, index) {
                              return CardEstacionamento(
                                  estacionamentoEntity:
                                      state.listEstacionamentos[index]);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    height: availableHeight,
                    width: MediaQuery.sizeOf(context).width,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text(
                            'Buscando estacionamentos...',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
