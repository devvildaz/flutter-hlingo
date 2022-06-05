import 'package:flutter/material.dart';
import 'package:hlinog/ui/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HoloLingo',
        theme: ThemeData(backgroundColor: const Color(0xFFFFFFFF)),
        initialRoute: '/lesson',
        routes: getRoutes());
  }
}
