import 'package:auto_park/features/pagamentos/cubit/pagamentos_cubit.dart';
import 'package:auto_park/features/pagamentos/cubit/pagamentos_state.dart';
import 'package:auto_park/features/pagamentos/widgets/card_pagamentos.dart';
import 'package:auto_park/features/pagamentos/widgets/selector_pagamentos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Pagamentos extends StatefulWidget {
  final PagamentosCubit pagamentosCubit;
  const Pagamentos({
    super.key,
    required this.pagamentosCubit,
  });

  @override
  State<Pagamentos> createState() => _PagamentosState();
}

class _PagamentosState extends State<Pagamentos> {
  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<PagamentosCubit, PagamentosState>(
        bloc: widget.pagamentosCubit,
        builder: (context, state) {
          return SizedBox(
            height: availableHeight,
            child: Column(
              children: [
                SizedBox(
                  height: availableHeight * 0.15,
                  child: SelectorPagamentos(
                    pagamentosCubit: widget.pagamentosCubit,
                  ),
                ),
                SizedBox(
                  height: availableHeight * 0.8,
                  child: Visibility(
                    visible:
                        state.statusPagamentos == StatusPagamentos.loadingList,
                    replacement: Visibility(
                      visible: state.selectedListPagamentos.isEmpty,
                      replacement: ListView.builder(
                          itemBuilder: (context, index) {
                            return CardPagamentos(
                              pagamentosEntity:
                                  state.selectedListPagamentos[index],
                            );
                          },
                          itemCount: state.selectedListPagamentos.length),
                      child: const Center(
                        child: Text(
                          'Nenhum pagamento encontrado',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: Text('Carregando a lista...'),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
