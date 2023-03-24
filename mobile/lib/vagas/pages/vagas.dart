import 'package:auto_park/vagas/cubit/vagas_cubit.dart';
import 'package:auto_park/vagas/cubit/vagas_state.dart';
import 'package:auto_park/vagas/widget/SelectorPageVagas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Vagas extends StatelessWidget {
  const Vagas({super.key});

  @override
  Widget build(BuildContext context) {
    VagasCubit vagasCubit = BlocProvider.of<VagasCubit>(context);
    return Scaffold(
      body: BlocBuilder<VagasCubit, VagasState>(
        bloc: vagasCubit,
        builder: (context, state) {
          return ListView(
            children: [
              SelectorVagasPage(
                vagasCubit: vagasCubit,
              )
            ],
          );
        },
      ),
    );
  }
}
