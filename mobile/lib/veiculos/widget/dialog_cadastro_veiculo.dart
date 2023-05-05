import 'package:auto_park/core/functions/validators.dart';
import 'package:auto_park/veiculos/cubit/veiculos_cubit.dart';
import 'package:flutter/material.dart';

class DialogCadastroVeiculo with Validators {
  final TextEditingController modeloController = TextEditingController();
  final TextEditingController marcaController = TextEditingController();
  final TextEditingController placaController = TextEditingController();
  final BuildContext context;
  final VeiculosCubit veiculosCubit;
  DialogCadastroVeiculo({required this.context, required this.veiculosCubit}) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextFormField(
                            validator: (value) => combineValidators(value, [
                              (value) => isNotEmpty(value),
                            ]),
                            controller: modeloController,
                            decoration: const InputDecoration(
                                label: Text('Modelo'),
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: TextFormField(
                              validator: (value) => combineValidators(value, [
                                (value) => isNotEmpty(value),
                              ]),
                              controller: marcaController,
                              decoration: const InputDecoration(
                                  label: Text('Marca'),
                                  labelStyle: TextStyle(color: Colors.white)),
                            ),
                          ),
                          TextFormField(
                            validator: (value) => combineValidators(value, [
                              (value) => isNotEmpty(value),
                            ]),
                            controller: placaController,
                            decoration: const InputDecoration(
                                label: Text('Placa'),
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                          onPressed: () => veiculosCubit.addVeiculo(
                              placaController.text,
                              marcaController.text,
                              modeloController.text),
                          child: const Text('Adicionar')),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
