import 'package:auto_park/core/functions/validators.dart';
import 'package:auto_park/features/login/cubit/login_cubit.dart';
import 'package:auto_park/features/login/cubit/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with Validators {
  LoginCubit loginCubit = GetIt.I<LoginCubit>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController =
      TextEditingController(text: 'teste2@gmail.com');
  TextEditingController senhaController =
      TextEditingController(text: 'senha123');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/logo.png',
                  width: MediaQuery.sizeOf(context).height * 0.3,
                  height: MediaQuery.sizeOf(context).width * 0.5,
                )),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 35),
                    child: Text(
                      'Bem-Vindo ao Smart Park',
                      style: TextStyle(
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocConsumer<LoginCubit, LoginState>(
                      bloc: loginCubit,
                      listener: (context, state) {
                        if (state.statusLogin == StatusLogin.sucessoLogin) {
                          Navigator.of(context).pushReplacementNamed('HOME');
                        }
                      },
                      builder: (context, state) {
                        return Form(
                          key: formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 17),
                                child: TextFormField(
                                  enabled: state.statusLogin !=
                                      StatusLogin.autenticandoLogin,
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      label: Text('E-mail'),
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
                                  validator: (value) =>
                                      combineValidators(value, [
                                    (value) => isNotEmpty(value),
                                    (value) => email(value!),
                                  ]),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 17),
                                child: TextFormField(
                                  obscureText: !state.obscureText,
                                  enabled: state.statusLogin !=
                                      StatusLogin.autenticandoLogin,
                                  controller: senhaController,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: state.obscureText
                                            ? const Icon(
                                                Icons.remove_red_eye_outlined)
                                            : const Icon(Icons.remove_red_eye),
                                        onPressed: () =>
                                            loginCubit.changeObscureText(),
                                      ),
                                      label: const Text('Senha'),
                                      labelStyle:
                                          const TextStyle(color: Colors.white)),
                                  validator: (value) =>
                                      combineValidators(value, [
                                    (value) => isNotEmpty(value),
                                    (value) => hasSeisCaracteres(value),
                                  ]),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom:
                                        MediaQuery.of(context).padding.bottom,
                                    top: 25),
                                child: SizedBox(
                                  height: 40,
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  child: Visibility(
                                    visible: state.statusLogin !=
                                        StatusLogin.autenticandoLogin,
                                    replacement: const Center(
                                        child: CircularProgressIndicator()),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          await loginCubit.login(
                                              emailController.text,
                                              senhaController.text);
                                        }
                                      },
                                      child: Text(
                                        'Entrar',
                                        style: TextStyle(
                                          color: Colors.purple[900],
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ainda não e cliente?'),
                    TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, 'CADASTRO'),
                        child: Text('Cadastre-se',
                            style: TextStyle(color: Colors.purple[200])))
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Versão: 1.0.0'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
