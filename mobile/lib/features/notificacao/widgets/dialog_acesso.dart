// ignore_for_file: must_be_immutable

import 'package:auto_park/core/data/dtos/notification_dto.dart';
import 'package:auto_park/features/notificacao/cubit/notificacao_cubit.dart';
import 'package:auto_park/features/notificacao/cubit/notificacao_state.dart';
import 'package:auto_park/features/notificacao/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class DialogAcesso {
  NotificacaoCubit notificacaoCubit = GetIt.I.get<NotificacaoCubit>();
  final NotificationDto notificationDto;
  final BuildContext context;
  DialogAcesso({required this.notificationDto, required this.context});
  show() => showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<NotificacaoCubit, NotificacaoState>(
          bloc: notificacaoCubit,
          builder: (context, state) {
            return Dialog(
              child: SizedBox(
                height: (state.statusNotificacao == StatusNotificacao.falha ||
                        state.statusNotificacao == StatusNotificacao.sucesso)
                    ? MediaQuery.sizeOf(context).height * 0.3
                    : MediaQuery.sizeOf(context).height * 0.6,
                width: MediaQuery.sizeOf(context).width * 0.8,
                child: BlocBuilder<NotificacaoCubit, NotificacaoState>(
                  bloc: notificacaoCubit,
                  builder: (context, state) {
                    return Visibility(
                      visible:
                          state.statusNotificacao == StatusNotificacao.enviando,
                      replacement: Visibility(
                        visible:
                            state.statusNotificacao == StatusNotificacao.falha,
                        replacement: Visibility(
                          visible: state.statusNotificacao ==
                              StatusNotificacao.sucesso,
                          replacement: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Você está tentando entrar?',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 17),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.6,
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
                                                value: notificationDto
                                                    .vehicleEntity.placa),
                                            CustomText(
                                                label: 'Modelo:',
                                                value: notificationDto
                                                    .vehicleEntity.modelo),
                                            CustomText(
                                                label: 'Marca:',
                                                value: notificationDto
                                                    .vehicleEntity.marca),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.6,
                                        child: Column(
                                          children: [
                                            const Text('Informações do acesso:',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            CustomText(
                                                label: 'Tipo:',
                                                value: notificationDto
                                                            .tipoDeAcesso ==
                                                        'in'
                                                    ? 'Entrada'
                                                    : 'Saida'),
                                            CustomText(
                                                label: 'Hora:',
                                                value: DateFormat(
                                                        'yyyy-MM-dd hh:mm:ss')
                                                    .format(DateTime.parse(
                                                        notificationDto
                                                            .datahora))),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        notificacaoCubit.answerNotificacao(
                                            notificationDto.tipoDeAcesso
                                                    .toLowerCase() ==
                                                'in',
                                            notificationDto
                                                .vehicleEntity.placa),
                                    label: const Text(
                                      'Sim, sou eu',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    icon: const Icon(Icons.check,
                                        color: Colors.green),
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.transparent),
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    //  notificacaoCubit.answerNotificacao(
                                    //      false,
                                    //      notificationDto
                                    //          .vehicleEntity.placa),
                                    label: const Text('Não, não permitir',
                                        style: TextStyle(color: Colors.white)),
                                    icon: const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    ),
                                    style: const ButtonStyle(
                                      backgroundColor:
                                          MaterialStatePropertyAll<Color>(
                                              Colors.transparent),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
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
                                      notificacaoCubit.reloadList();
                                    },
                                    child: const Text(
                                      'Fechar',
                                      style: TextStyle(color: Colors.white),
                                    ))
                              ]),
                        ),
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
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                ),
              ),
            );
          },
        );
      });
}
