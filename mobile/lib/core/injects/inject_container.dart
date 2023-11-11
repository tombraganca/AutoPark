import 'package:auto_park/core/injects/inject_answer_notification.dart';
import 'package:auto_park/core/injects/inject_auth.dart';
import 'package:auto_park/core/injects/inject_estacionamento.dart';
import 'package:auto_park/core/injects/inject_fcm.dart';
import 'package:auto_park/core/injects/inject_firebase_messaging.dart';
import 'package:auto_park/core/injects/inject_home.dart';
import 'package:auto_park/core/injects/inject_http.dart';
import 'package:auto_park/core/injects/inject_notificacao.dart';
import 'package:auto_park/core/injects/inject_notification_service.dart';
import 'package:auto_park/core/injects/inject_pagamentos.dart';
import 'package:auto_park/core/injects/inject_registros.dart';
import 'package:auto_park/core/injects/inject_user.dart';
import 'package:auto_park/core/injects/inject_vagas.dart';
import 'package:auto_park/core/injects/inject_veiculos.dart';
import 'package:get_it/get_it.dart';

Future<void> injectContainer() async {
  GetIt getIt = GetIt.instance;
  injectHttp(getIt);
  injectUser(getIt);
  injectAuth(getIt);
  injectFcm(getIt);
  injectHome(getIt);
  injectVeiculos(getIt);
  injectRegistros(getIt);
  injectVagas(getIt);
  injectFirebaseMessaging(getIt);
  injectNotificationService(getIt);
  initInjectNotificacao(getIt);
  injectPagamentos(getIt);
  injectEstacionamento(getIt);
  initInjectAnswerNotificacao(getIt);
}
