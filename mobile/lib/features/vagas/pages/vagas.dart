import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/features/vagas/cubit/vagas_cubit.dart';
import 'package:auto_park/features/vagas/cubit/vagas_state.dart';
import 'package:auto_park/features/vagas/widget/selector_page_vagas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_park/features/vagas/widget/card_vagas.dart';
import 'package:get_it/get_it.dart';

class Vagas extends StatefulWidget {
  final UserEntity userEntity;
  const Vagas({super.key, required this.userEntity});

  @override
  State<Vagas> createState() => _VagasState();
}

class _VagasState extends State<Vagas> {
  VagasCubit vagasCubit = GetIt.I.get<VagasCubit>();
  @override
  void initState() {
    vagasCubit.setUser(widget.userEntity);
    vagasCubit.getVagas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.of(context).size.height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      body: BlocBuilder<VagasCubit, VagasState>(
          bloc: vagasCubit,
          builder: (context, state) {
            return Column(
              children: [
                // SegmentedButton(
                //   segments: const [
                //     ButtonSegment(
                //         label: Text('Disponível'),
                //         value: SelectListVagas.disponivel),
                //     ButtonSegment(
                //       label: Text('Todas'),
                //       value: SelectListVagas.todas,
                //     ),
                //   ],
                //   selected: {state.selectListVagas},
                //   onSelectionChanged: (value) =>
                //       vagasCubit.changeList(value.first!),
                // ),
                SizedBox(
                  height: availableHeight * 0.15,
                  child: SelectorVagas(
                    vagasCubit: vagasCubit,
                  ),
                ),
                Visibility(
                  visible: state.statusVagas == StatusVagas.buscandoVagas,
                  replacement: SizedBox(
                    height: availableHeight * 0.80,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      itemCount: state.listSelected.length,
                      itemBuilder: (context, index) {
                        return CardVagas(vagaEntity: state.listSelected[index]);
                      },
                    ),
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ],
            );
          }),
    );
  }
}
