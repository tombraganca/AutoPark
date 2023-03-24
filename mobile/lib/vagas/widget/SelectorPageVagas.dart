import 'package:auto_park/vagas/cubit/vagas_cubit.dart';
import 'package:auto_park/vagas/cubit/vagas_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectorVagasPage extends StatelessWidget {
  final VagasCubit vagasCubit;
  const SelectorVagasPage({super.key, required this.vagasCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VagasCubit, VagasState>(
      bloc: vagasCubit,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () =>
                      vagasCubit.changeList(SelectListVagas.disponivel),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
                    decoration: BoxDecoration(
                      color: state.selectListVagas == SelectListVagas.disponivel
                          ? Colors.grey[700]
                          : null,
                      border: Border.all(width: 1.0, color: Colors.white),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                    child: const Tab(
                      child: Text(
                        'Hoje',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => vagasCubit.changeList(SelectListVagas.todas),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
                    decoration: BoxDecoration(
                      color: state.selectListVagas == SelectListVagas.todas
                          ? Colors.grey[700]
                          : null,
                      border: Border.all(width: 1.0, color: Colors.white),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                    child: const Tab(
                      child: Text(
                        'Todos',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
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
