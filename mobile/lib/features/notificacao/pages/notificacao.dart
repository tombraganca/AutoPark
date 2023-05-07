import 'package:auto_park/features/notificacao/cubit/notificacao_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Notificacao extends StatefulWidget {
  const Notificacao({super.key});

  @override
  State<Notificacao> createState() => _NotificacaoState();
}

class _NotificacaoState extends State<Notificacao> {
  NotificacaoCubit notificacaoCubit = GetIt.I.get<NotificacaoCubit>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Você está tentando entrar?'),
        Row(
          children: [
            Column(
              children: [
                Text('Informações do carro:'),
                Text(''),
                Text(''),
                Text(''),
              ],
            )
          ],
        ),
        Row(
          children: [
            Column(
              children: [
                Text('Informações do acesso:'),
                Text(''),
                Text(''),
              ],
            )
          ],
        ),
        Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text(
                'Sim,sou eu',
                style: TextStyle(color: Colors.white),
              ),
              icon: const Icon(Icons.check, color: Colors.green),
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.transparent),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text('Não,não permitir',
                  style: TextStyle(color: Colors.white)),
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
              style: const ButtonStyle(
                backgroundColor:
                    MaterialStatePropertyAll<Color>(Colors.transparent),
              ),
            ),
          ],
        )
      ],
    );
  }
}
