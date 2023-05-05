import 'package:auto_park/core/injects/inject_auth.dart';
import 'package:auto_park/core/injects/inject_home.dart';
import 'package:auto_park/core/injects/inject_http.dart';
import 'package:auto_park/core/injects/inject_registros.dart';
import 'package:auto_park/core/injects/inject_vagas.dart';
import 'package:auto_park/core/injects/inject_veiculos.dart';
import 'package:get_it/get_it.dart';

Future<void> injectContainer() async {
  GetIt getIt = GetIt.instance;
  injectHttp(getIt);
  injectAuth(getIt);
  injectHome(getIt);
  injectVeiculos(getIt);
  injectRegistros(getIt);
  injectVagas(getIt);
}
