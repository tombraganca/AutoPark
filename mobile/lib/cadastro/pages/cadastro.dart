import 'package:auto_park/cadastro/cubit/cadastro_cubit.dart';
import 'package:auto_park/cadastro/cubit/cadastro_state.dart';
import 'package:auto_park/core/functions/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

final AppBar appBar = AppBar(
  title: const Text('Cadastro'),
  centerTitle: true,
);

class _CadastroState extends State<Cadastro> with Validators {
  final CadastroCubit cadastroCubit = GetIt.I.get<CadastroCubit>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final availableHeight = MediaQuery.of(context).size.height -
        (appBar.preferredSize.height + MediaQuery.of(context).padding.top);
    return Scaffold(
      appBar: appBar,
      body: SizedBox(
        height: availableHeight,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Center(
                  child: Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.height * 0.3,
                height: MediaQuery.of(context).size.width * 0.5,
              )),
            ),
            BlocConsumer<CadastroCubit, CadastroState>(
              bloc: cadastroCubit,
              listener: (context, state) {
                if (state.statusCadastro == StatusCadastro.succesoCadastro) {
                  Navigator.of(context).pop();
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: availableHeight * 0.5,
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: TextFormField(
                            validator: (value) => combineValidators(value, [
                              (value) => isNotEmpty(value),
                              (value) => email(value!),
                            ]),
                            controller: emailController,
                            decoration: const InputDecoration(
                                label: Text('E-mail'),
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: TextFormField(
                            validator: (value) => combineValidators(value, [
                              (value) => isNotEmpty(value),
                              (value) => hasSeisCaracteres(value!),
                            ]),
                            controller: senhaController,
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: state.obscureText
                                      ? const Icon(
                                          Icons.remove_red_eye_outlined)
                                      : const Icon(Icons.remove_red_eye),
                                  onPressed: () =>
                                      cadastroCubit.changeObscureText(),
                                ),
                                label: const Text('Senha'),
                                labelStyle:
                                    const TextStyle(color: Colors.white)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7),
                          child: TextFormField(
                            validator: (value) => combineValidators(value, [
                              (value) => isNotEmpty(value),
                              (value) => hasSeisCaracteres(value!),
                            ]),
                            controller: nomeController,
                            decoration: const InputDecoration(
                                label: Text('Nome'),
                                labelStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cadastroCubit.cadastrar(emailController.text,
                          senhaController.text, nomeController.text);
                    }
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(
                      color: Colors.purple[900],
                      fontSize: 18,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
