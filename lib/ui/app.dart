import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:hlingo/bloc/camera/camera_bloc.dart";
import 'package:hlingo/bloc/user/user_bloc.dart';
import 'package:hlingo/routes/auth_guard.dart';
import 'package:hlingo/routes/router.gr.dart';

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // configuracion del paquete para la generacion de la instancia appRouter
  final _appRouter = AppRouter(authGuard: AuthGuard());

  // Configuracion para la proveecion de los Bloc
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        // inicializacion del estado del Block al modo inicial
        providers: [
          BlocProvider(create: (_) => CameraBloc()),
          BlocProvider(create: (_) => UserBloc()..add(InitUser()))
        ],
        // configuracion necesaria para el funcionamiento del auto_router
        child: MaterialApp.router(
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate()));
  }
}
