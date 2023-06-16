import 'package:auto_park/core/injects/inject_container.dart';
import 'package:auto_park/core/rotas/routes_app.dart';
import 'package:auto_park/core/services/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectContainer();
  await Firebase.initializeApp();
  await GetIt.I.get<FirebaseMessagingService>().initialize();
  debugPrint(
      await GetIt.I.get<FirebaseMessagingService>().getDeviceFirebaseToken());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final RoutesApp _routesApp = RoutesApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      locale: const Locale('pt_Br'),
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          secondary: Color.fromARGB(255, 208, 188, 255),
        ),
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(backgroundColor: Colors.black),
        brightness: Brightness.dark,
        inputDecorationTheme: const InputDecorationTheme(
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(
                Color.fromARGB(255, 208, 188, 255)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ),
      theme: ThemeData(brightness: Brightness.light),
      themeMode: ThemeMode.dark,
      onGenerateRoute: _routesApp.generateRoute,
      navigatorKey: _routesApp.navigatorGlobalKey,
      initialRoute: 'LOGIN',
    );
  }
}
