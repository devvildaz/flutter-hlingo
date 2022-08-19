import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hlingo/bloc/camera/camera_bloc.dart';
import 'package:hlingo/ui/app.dart';
import 'package:get_it/get_it.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    // Configuracion para aceptar conexiones inseguras HTTP
    return super.createHttpClient(context)
      ..badCertificateCallback = // callback ejecutado cuando se detecta una conexion insegura
          (X509Certificate cert, String host, int port) => true;
    // el retorno indica si dicha conexion deberia ser aceptada
  }
}

final serviceLocator = GetIt.instance;

void setUp() {
  serviceLocator.registerSingleton<CameraBloc>(CameraBloc());
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  setUp();
  runApp(MyApp());
}
