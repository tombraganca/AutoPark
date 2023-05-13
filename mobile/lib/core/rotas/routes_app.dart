import 'package:auto_park/core/data/dtos/notification_dto.dart';
import 'package:auto_park/core/data/dtos/user_dto.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/features/cadastro/pages/cadastro.dart';
import 'package:auto_park/features/home/pages/home.dart';
import 'package:auto_park/features/login/pages/login.dart';
import 'package:auto_park/features/notificacao/widgets/dialog_acesso.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RoutesApp {
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  get navigatorGlobalKey => navigatorKey;
  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    UserDto userDto = GetIt.I.get<UserDtoGlobal>().getUser();
    if (userDto.token.isNotEmpty) {
      switch (settings.name!.toUpperCase()) {
        case 'LOGIN':
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const Login(),
          );
        case 'HOME':
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => Home(),
          );
        case 'CADASTRO':
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const Cadastro(),
          );
        case 'NOTIFICACAO':
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => Home(
              showDialogAcesso: (() => DialogAcesso(
                      notificationDto: args as NotificationDto,
                      context: context)
                  .show()),
            ),
          );

        default:
          return MaterialPageRoute(
            settings: settings,
            builder: ((context) => const Login()),
          );
      }
    }
    return MaterialPageRoute(
      settings: settings,
      builder: ((context) => const Login()),
    );
  }
}
