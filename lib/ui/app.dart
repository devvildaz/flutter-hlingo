import 'package:flutter/material.dart';
import 'package:hlinog/ui/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HoloLingo',
        initialRoute: '/',
        routes: getRoutes());
  }
}
