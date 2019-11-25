import 'package:flutter/material.dart';
import 'package:push_local/src/pages/login_page.dart';
import 'package:push_local/src/providers/push_notifications_provider.dart';

import 'package:push_local/src/pages/home_page.dart';
import 'package:push_local/src/pages/mensaje_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final pushProvider = new PushNotificationProvider();

  @override
  void initState() {
    super.initState();

    pushProvider.mensajes.listen((data) {
      // Navigator.pushNamed(context, 'mensaje');
      print('Argumento del Push');
      print(data);

      navigatorKey.currentState.pushNamed('mensaje', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    pushProvider.initNotifications(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Push Local',
      initialRoute: 'login',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mensaje': (BuildContext context) => MensajePage(),
        'login': (BuildContext context) => LoginPage(),
      },
    );
  }
}
