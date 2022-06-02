import 'package:flutter/material.dart';
import 'package:hlinog/ui/pages/home_page.dart';

// Aquí ponen sus rutas o reemplazan los placeholders q puse

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Landing'),
          ),
          body: ElevatedButton(
            child: const Text("Ir a home"),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
    '/home': (context) => const HomePage(),
    '/profile': (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: ElevatedButton(
            child: const Text("Ir a home"),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),
  };
}
