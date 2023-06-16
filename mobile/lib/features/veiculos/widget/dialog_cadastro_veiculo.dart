import 'package:auto_park/core/functions/validators.dart';
import 'package:auto_park/features/veiculos/cubit/veiculos_cubit.dart';
import 'package:auto_park/features/veiculos/cubit/veiculos_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogCadastroVeiculo with Validators {
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final BuildContext context;
  final VeiculosCubit veiculosCubit;
  DialogCadastroVeiculo({required this.context, required this.veiculosCubit}) {
    final formKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (context) {
          return BlocBuilder<VeiculosCubit, VeiculosState>(
            bloc: veiculosCubit,
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () async {
                  veiculosCubit.reloadList();
                  return true;
                },
                child: Dialog(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    child: SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.50,
                      child: Visibility(
                        visible: state.statusVeiculos ==
                            StatusVeiculos.adicionandoVeiculo,
                        replacement: Visibility(
                          visible: state.statusVeiculos ==
                              StatusVeiculos.errorAddVeiculo,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextFormField(
                                      validator: (value) =>
                                          combineValidators(value, [
                                        (value) => isNotEmpty(value),
                                      ]),
                                      controller: modeloController,
                                      decoration: const InputDecoration(
                                          label: Text('Modelo'),
                                          labelStyle:
                                              TextStyle(color: Colors.white)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      child: TextFormField(
                                        validator: (value) =>
                                            combineValidators(value, [
                                          (value) => isNotEmpty(value),
                                        ]),
                                        controller: marcaController,
                                        decoration: const InputDecoration(
                                            label: Text('Marca'),
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ),
                                    TextFormField(
                                      validator: (value) =>
                                          combineValidators(value, [
                                        (value) => isNotEmpty(value),
                                      ]),
                                      controller: placaController,
                                      decoration: const InputDecoration(
                                          label: Text('Placa'),
                                          labelStyle:
                                              TextStyle(color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.7,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        veiculosCubit.addVeiculo(
                                            placaController.text,
                                            marcaController.text,
                                            modeloController.text);
                                      }
                                    },
                                    child: const Text('Adicionar')),
                              )
                            ],
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(
                                  Icons.error,
                                  size: 48,
                                  color: Colors.red,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    state.erroMsg,
                                    style: const TextStyle(fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      veiculosCubit.reloadList();
                                    },
                                    child: const Text(
                                      'Fechar',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ]),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
