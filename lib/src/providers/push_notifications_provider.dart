import 'package:firebase_messaging/firebase_messaging.dart';

import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';

class PushNotificationProvider {

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;


  initNotifications(BuildContext context) {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then( (token) {
      print( token );
    });
    _firebaseMessaging.configure(
      onMessage: ( info ) {
        String argumento = 'no-data';
        if ( Platform.isAndroid  ) {  
          argumento = info['data']['codigoUsuario'] ?? 'no-data';
        } else {
          argumento = info['codigoUsuario'] ?? 'no-data-ios';
        }
        _mensajesStreamController.sink.add(argumento);
         Navigator.pushReplacementNamed( context,'mensaje');

      },
      onLaunch: ( info ) {
        print( info );
        String argumento = 'no-data';
        if ( Platform.isAndroid  ) {  
          argumento = info['data']['codigoUsuario'] ?? 'no-data';
        } else {
          argumento = info['codigoUsuario'] ?? 'no-data-ios';
        }
        _mensajesStreamController.sink.add(argumento);
         Navigator.pushReplacementNamed( context,'mensaje');
      },
      onResume: ( info ) {
        print( info );
        String argumento = 'no-data';
        if ( Platform.isAndroid  ) {  
          argumento = info['data']['codigoUsuario'] ?? 'no-data';
        } else {
          argumento = info['codigoUsuario'] ?? 'no-data-ios';
        }
        _mensajesStreamController.sink.add(argumento);
         Navigator.pushReplacementNamed( context,'mensaje');
      }
    );
  }


  dispose() {
    _mensajesStreamController?.close();
  }

}

