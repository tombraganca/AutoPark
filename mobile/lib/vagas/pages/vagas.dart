import 'package:auto_park/vagas/cubit/vagas_cubit.dart';
import 'package:auto_park/vagas/cubit/vagas_state.dart';
import 'package:auto_park/vagas/widget/card_vagas.dart';
import 'package:auto_park/vagas/widget/selector_page_vagas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Vagas extends StatelessWidget {
  const Vagas({super.key});
  @override
  Widget build(BuildContext context) {
    final AppBar appBar = AppBar();
    VagasCubit vagasCubit = BlocProvider.of<VagasCubit>(context);
    return Scaffold(
      appBar: appBar,
      body: BlocBuilder<VagasCubit, VagasState>(
        bloc: vagasCubit,
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        (appBar.preferredSize.height +
                            MediaQuery.of(context).padding.top)) *
                    0.10,
                child: SelectorVagasPage(
                  vagasCubit: vagasCubit,
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height) *
                    0.80,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: state.listVagas.length,
                  itemBuilder: (context, index) {
                    return CardVagas(vagaEntity: state.listVagas[index]);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
