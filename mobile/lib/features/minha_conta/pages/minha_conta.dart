import 'package:auto_park/features/minha_conta/cubit/minha_conta_cubit.dart';
import 'package:auto_park/features/minha_conta/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class MinhaConta extends StatelessWidget {
  final MinhaContaCubit minhaContaCubit;

  const MinhaConta({
    super.key,
    required this.minhaContaCubit,
  });

  @override
  Widget build(BuildContext context) {
    final availableHeight = (MediaQuery.sizeOf(context).height -
        (AppBar().preferredSize.height + MediaQuery.of(context).padding.top));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Conta'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: availableHeight * 0.45,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(
                    child: Image.asset(
                  'assets/images/default_user.png',
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.3,
                )),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Toninho da Borracharia',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                const Center(
                  child: Text('toninho23@hotmail.com'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: availableHeight * 0.55,
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, 'DADOS_BANCARIOS'),
                    label: 'Dados Bancários'),
                CustomButton(
                    onPressed: () => Navigator.pushNamed(
                        context, 'EDITAR_DADOS',
                        arguments: minhaContaCubit),
                    label: 'Editar dados'),
                CustomButton(
                    onPressed: () => Navigator.pushNamedAndRemoveUntil(
                        context, 'LOGIN', (route) => false),
                    label: 'Sair'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
