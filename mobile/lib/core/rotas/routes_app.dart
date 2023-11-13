import 'package:auto_park/core/data/dtos/notification_dto.dart';
import 'package:auto_park/features/cadastro/pages/cadastro.dart';
import 'package:auto_park/features/dados_bancarios/cubit/dados_bancarios_cubit.dart';
import 'package:auto_park/features/dados_bancarios/pages/dados_bancarios.dart';
import 'package:auto_park/features/home/cubit/home_cubit.dart';
import 'package:auto_park/features/home/pages/home.dart';
import 'package:auto_park/features/login/pages/login.dart';
import 'package:auto_park/features/minha_conta/cubit/minha_conta_cubit.dart';
import 'package:auto_park/features/minha_conta/pages/editar_dados.dart';
import 'package:auto_park/features/minha_conta/pages/minha_conta.dart';
import 'package:auto_park/features/notificacao/widgets/dialog_acesso.dart';
import 'package:auto_park/features/vagas/cubit/vagas_cubit.dart';
import 'package:auto_park/features/vagas/pages/vagas.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RoutesApp {
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  get navigatorGlobalKey => navigatorKey;
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name!.toUpperCase()) {
      case 'LOGIN':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Login(),
        );
      case 'HOME':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Home(
            homeCubit: GetIt.I.get<HomeCubit>(),
          ),
        );

      case 'NOTIFICACAO':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Home(
            homeCubit: GetIt.I.get<HomeCubit>(),
            showDialogAcesso: (() => DialogAcesso(
                    notificationDto: args as NotificationDto, context: context)
                .show()),
          ),
        );
      case 'CADASTRO':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const Cadastro(),
        );
      case 'MINHA_CONTA':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MinhaConta(
            minhaContaCubit: GetIt.I.get<MinhaContaCubit>(),
          ),
        );
      case 'DADOS_BANCARIOS':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => DadosBancariosPage(
            dadosBancariosCubit: GetIt.I.get<DadosBancariosCubit>(),
          ),
        );
      case 'EDITAR_DADOS':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => EditarDados(
            minhaContaCubit: args as MinhaContaCubit,
          ),
        );
      case 'VAGAS':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Vagas(
            vagasCubit: GetIt.I.get<VagasCubit>(),
            parkingId: args as String,
          ),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: ((context) => const Login()),
        );
    }
  }
}
