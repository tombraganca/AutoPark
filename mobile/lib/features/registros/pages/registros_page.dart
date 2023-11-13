import 'package:auto_park/features/registros/cubit/registros_cubit.dart';
import 'package:auto_park/features/registros/cubit/registros_state.dart';
import 'package:auto_park/features/registros/widgets/cards_registros.dart';
import 'package:auto_park/features/registros/widgets/selector_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrosPage extends StatefulWidget {
  final RegistrosCubit registrosCubit;
  const RegistrosPage({
    required this.registrosCubit,
    super.key,
  });

  @override
  State<RegistrosPage> createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage> {
  @override
  void initState() {
    widget.registrosCubit.gerRegistros();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<RegistrosCubit, RegistrosState>(
        bloc: widget.registrosCubit,
        builder: (context, state) {
          return SizedBox(
            height: availableHeight,
            child: Column(
              children: [
                SizedBox(
                  height: availableHeight * 0.15,
                  child: SelectorPage(
                    registrosCubit: widget.registrosCubit,
                  ),
                ),
                SizedBox(
                  height: availableHeight * 0.8,
                  child: Visibility(
                    visible:
                        state.statusRegistros == StatusRegistros.loadingList,
                    replacement: Visibility(
                      visible: state.listRegistros.isEmpty,
                      replacement: RefreshIndicator(
                        onRefresh: () => widget.registrosCubit.gerRegistros(),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return CardRegistros(
                                  title: state.listRegistros[index].title,
                                  placa: state.listRegistros[index].placa,
                                  date: state.listRegistros[index].date);
                            },
                            separatorBuilder: (context, index) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15),
                                child: Divider(
                                  color: Colors.white,
                                  height: 5,
                                ),
                              );
                            },
                            itemCount: state.listRegistros.length),
                      ),
                      child: const Center(
                        child: Text(
                          'Nenhum registro encontrado',
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
                          child: Text('Carregando os registros...'),
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
