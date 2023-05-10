import 'package:auto_park/features/registros/cubit/registros_cubit.dart';
import 'package:auto_park/features/registros/cubit/registros_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectorPage extends StatelessWidget {
  final RegistrosCubit registrosCubit;
  const SelectorPage({super.key, required this.registrosCubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrosCubit, RegistrosState>(
      bloc: registrosCubit,
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
                  onTap: () => registrosCubit.changeList(SelectList.hoje),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
                    decoration: BoxDecoration(
                      color: state.selectList == SelectList.hoje
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
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () =>
                      registrosCubit.changeList(SelectList.ultimaSemana),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
                    decoration: BoxDecoration(
                      color: state.selectList == SelectList.ultimaSemana
                          ? Colors.grey[700]
                          : null,
                      border: Border.all(width: 1.0, color: Colors.white),
                    ),
                    child: const Tab(
                      child: Text('Última semana',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => registrosCubit.changeList(SelectList.todos),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.2,
                    decoration: BoxDecoration(
                      color: state.selectList == SelectList.todos
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