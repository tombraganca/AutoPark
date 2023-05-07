import 'package:auto_park/core/data/dtos/user_dto.dart';
import 'package:auto_park/core/injects/userSingleton/user_global_singleton.dart';
import 'package:auto_park/features/home/pages/home.dart';
import 'package:auto_park/features/login/pages/login.dart';
import 'package:auto_park/features/notificacao/pages/notificacao.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class RoutesApp {
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  get navigatorGlobalKey => navigatorKey;
  static Map<String, MaterialPageRoute> rota = {
    'LOGIN': MaterialPageRoute(
      builder: (context) => const Login(),
    ),
    'HOME': MaterialPageRoute(
      builder: (context) => const Home(),
    ),
    'NOTIFICACAO': MaterialPageRoute(
      builder: (context) => const Notificacao(),
    ),
  };
  Route<dynamic> generateRoute(RouteSettings settings) {
    UserDto userDto = GetIt.I.get<UserDtoGlobal>().getUser();
    if (userDto.token.isNotEmpty) {
      return rota[settings.name!.toUpperCase()] ??
          MaterialPageRoute(
            settings: settings,
            builder: ((context) => const Login()),
          );
    }
    return MaterialPageRoute(
      settings: settings,
      builder: ((context) => const Login()),
    );
  }
}
