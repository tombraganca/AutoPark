import 'package:auto_park/core/domain/entities/notificatio_entity.dart';
import 'package:auto_park/features/notificacao/cubit/notificacao_cubit.dart';
import 'package:auto_park/features/notificacao/cubit/notificacao_state.dart';
import 'package:auto_park/features/notificacao/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Notificacao extends StatelessWidget {
  final NotificationEntity notificationEntity;
  final NotificacaoCubit notificacaoCubit;
  const Notificacao({
    super.key,
    required this.notificacaoCubit,
    required this.notificationEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Notificação de Acesso'),
      ),
      body: BlocConsumer<NotificacaoCubit, NotificacaoState>(
        bloc: notificacaoCubit,
        listener: (context, state) {
          if (state.statusNotificacao == StatusNotificacao.sucesso) {
            Navigator.pushReplacementNamed(context, 'VAGAS',
                arguments: notificationEntity.parkingId);
          }
        },
        builder: (context, state) {
          return Visibility(
            visible: state.statusNotificacao == StatusNotificacao.enviando,
            replacement: Visibility(
              visible: state.statusNotificacao == StatusNotificacao.falha,
              replacement: Visibility(
                visible: state.statusNotificacao == StatusNotificacao.sucesso,
                replacement: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Você está tentando entrar?',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: Column(
                                children: [
                                  const Text(
                                    'Informações do carro:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  CustomText(
                                      label: 'Placa:',
                                      value: notificationEntity
                                          .vehicleEntity.placa),
                                  CustomText(
                                      label: 'Modelo:',
                                      value: notificationEntity
                                          .vehicleEntity.modelo),
                                  CustomText(
                                      label: 'Marca:',
                                      value: notificationEntity
                                          .vehicleEntity.marca),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: Column(
                                children: [
                                  const Text('Informações do acesso:',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  CustomText(
                                      label: 'Tipo:',
                                      value: notificationEntity.tipoDeAcesso ==
                                              'in'
                                          ? 'Entrada'
                                          : 'Saida'),
                                  CustomText(
                                      label: 'Hora:',
                                      value: DateFormat('yyyy-MM-dd hh:mm:ss')
                                          .format(DateTime.parse(
                                              notificationEntity.datahora))),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => notificacaoCubit.answerNotificacao(
                            notificationEntity.tipoDeAcesso.toLowerCase() ==
                                'in',
                            notificationEntity.vehicleEntity.placa,
                          ),
                          label: const Text(
                            'Sim, sou eu',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: const Icon(Icons.check, color: Colors.green),
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.transparent),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => Navigator.of(context).pop(),
                          label: const Text('Não, não permitir',
                              style: TextStyle(color: Colors.white)),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.transparent),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 72,
                          color: Colors.green,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Estamos liberando a cancela.',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Fechar',
                              style: TextStyle(color: Colors.white),
                            ))
                      ]),
                ),
              ),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.error,
                        size: 48,
                        color: Colors.red,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Error ao enviar a resposta.',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            notificacaoCubit.reloadList();
                          },
                          child: const Text(
                            'Fechar',
                            style: TextStyle(color: Colors.white),
                          ))
                    ]),
              ),
            ),
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
