import 'package:auto_park/features/pagamentos/cubit/pagamentos_cubit.dart';
import 'package:auto_park/features/pagamentos/cubit/pagamentos_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectorPagamentos extends StatelessWidget {
  final PagamentosCubit pagamentosCubit;
  const SelectorPagamentos({super.key, required this.pagamentosCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PagamentosCubit, PagamentosState>(
      bloc: pagamentosCubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            width: MediaQuery.sizeOf(context).width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () =>
                      pagamentosCubit.changeList(SelectListPagamentos.emAberto),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width / 3.2,
                    decoration: BoxDecoration(
                      color: state.selectListPagamentos ==
                              SelectListPagamentos.emAberto
                          ? const Color.fromRGBO(74, 68, 88, 1)
                          : null,
                      border: Border.all(width: 1.0, color: Colors.white),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    child: const Tab(
                      child: Text(
                        'Em Aberto',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      pagamentosCubit.changeList(SelectListPagamentos.vencidos),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width / 3.2,
                    decoration: BoxDecoration(
                      color: state.selectListPagamentos ==
                              SelectListPagamentos.vencidos
                          ? const Color.fromRGBO(74, 68, 88, 1)
                          : null,
                      border: Border.all(width: 1.0, color: Colors.white),
                    ),
                    child: const Tab(
                      child: Text('Vencidos',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      pagamentosCubit.changeList(SelectListPagamentos.pagos),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width / 3.2,
                    decoration: BoxDecoration(
                      color: state.selectListPagamentos ==
                              SelectListPagamentos.pagos
                          ? const Color.fromRGBO(74, 68, 88, 1)
                          : null,
                      border: Border.all(width: 1.0, color: Colors.white),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: const Tab(
                      child: Text(
                        'Pagos',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
