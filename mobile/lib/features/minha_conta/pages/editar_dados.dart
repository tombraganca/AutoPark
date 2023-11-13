import 'package:auto_park/core/functions/validators.dart';
import 'package:auto_park/features/minha_conta/cubit/minha_conta_cubit.dart';
import 'package:auto_park/features/minha_conta/cubit/minha_conta_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditarDados extends StatefulWidget {
  final MinhaContaCubit minhaContaCubit;

  const EditarDados({super.key, required this.minhaContaCubit});

  @override
  State<EditarDados> createState() => _EditarDadosState();
}

class _EditarDadosState extends State<EditarDados> with Validators {
  final senhaController = TextEditingController();
  final newSenhaController = TextEditingController();
  final confirmNewSenhaController = TextEditingController();
  final emailController = TextEditingController();
  final nomeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height + MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Editar dados'),
      ),
      body: SizedBox(
        height: availableHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BlocBuilder<MinhaContaCubit, MinhaContaState>(
              bloc: widget.minhaContaCubit,
              builder: (context, state) {
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: TextFormField(
                          validator: (value) => combineValidators(value, [
                            (value) => isNotEmpty(value),
                            (value) => email(value!),
                          ]),
                          controller: emailController,
                          decoration: const InputDecoration(
                              label: Text('E-mail:'),
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: TextFormField(
                          validator: (value) => combineValidators(value, [
                            (value) => isNotEmpty(value),
                            (value) => email(value!),
                          ]),
                          controller: nomeController,
                          decoration: const InputDecoration(
                              label: Text('Nome:'),
                              labelStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: TextFormField(
                          validator: (value) => combineValidators(value, [
                            (value) => isNotEmpty(value),
                            (value) => hasSeisCaracteres(value!),
                          ]),
                          controller: senhaController,
                          obscureText: state.obscureText,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: state.obscureText
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.remove_red_eye),
                                onPressed: () =>
                                    widget.minhaContaCubit.changeObscureText(),
                              ),
                              label: const Text('Nova Senha:'),
                              labelStyle: const TextStyle(color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: TextFormField(
                          validator: (value) => combineValidators(value, [
                            (value) => isNotEmpty(value),
                            (value) => hasSeisCaracteres(value!),
                          ]),
                          obscureText: state.obscureText,
                          controller: confirmNewSenhaController,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: state.obscureText
                                    ? const Icon(Icons.remove_red_eye_outlined)
                                    : const Icon(Icons.remove_red_eye),
                                onPressed: () =>
                                    widget.minhaContaCubit.changeObscureText(),
                              ),
                              label: const Text('Confirme a nova senha:'),
                              labelStyle: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(
                height: 50,
                width: MediaQuery.sizeOf(context).width * 0.5,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    'Confirmar',
                    style: TextStyle(fontSize: 18),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
