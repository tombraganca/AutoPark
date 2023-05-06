import 'package:auto_park/core/injects/inject_container.dart';
import 'package:flutter/material.dart';
import 'login/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injectContainer();
  await Firebase.initializeApp();

  FirebaseMessaging.instance.getToken().then((value) => print("GetToken :  $value"));

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print("onMessage : $message");
  });

  FirebaseMessaging.instance.getInitialMessage().then(
    (RemoteMessage? message) {
      if (message != null) {
        print("getInitialMessage : $message");
     }
    }
  );
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Colors.black,
          secondary: Color.fromARGB(255, 208, 188, 255),
        ),
        bottomNavigationBarTheme:
            BottomNavigationBarThemeData(backgroundColor: Colors.black),
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
      home: const Login(),
    );
  }
}
