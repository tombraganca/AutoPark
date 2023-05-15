import 'package:auto_park/core/domain/entities/user_entity.dart';
import 'package:auto_park/features/registros/cubit/registros_cubit.dart';
import 'package:auto_park/features/registros/cubit/registros_state.dart';
import 'package:auto_park/features/registros/widgets/cards_registros.dart';
import 'package:auto_park/features/registros/widgets/selector_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class RegistrosPage extends StatefulWidget {
  final UserEntity userEntity;
  const RegistrosPage({
    required this.userEntity,
    super.key,
  });

  @override
  State<RegistrosPage> createState() => _RegistrosPageState();
}

class _RegistrosPageState extends State<RegistrosPage> {
  final RegistrosCubit registrosCubit = GetIt.I.get<RegistrosCubit>();
  @override
  void initState() {
    registrosCubit.setUser(widget.userEntity);
    registrosCubit.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.of(context).size.height -
        (AppBar().preferredSize.height +
            MediaQuery.of(context).padding.top +
            kBottomNavigationBarHeight));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<RegistrosCubit, RegistrosState>(
        bloc: registrosCubit,
        builder: (context, state) {
          return SizedBox(
            height: availableHeight,
            child: Column(
              children: [
                SizedBox(
                  height: availableHeight * 0.15,
                  child: SelectorPage(
                    registrosCubit: registrosCubit,
                  ),
                ),
                SizedBox(
                  height: availableHeight * 0.8,
                  child: Visibility(
                    visible:
                        state.statusRegistros != StatusRegistros.loadingList,
                    replacement: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                        Text('Carregando a lista...')
                      ],
                    ),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return CardRegistros(
                              title: state.listRegistros[index].title,
                              registro: state.listRegistros[index].registro,
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
