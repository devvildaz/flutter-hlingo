import 'package:flutter/material.dart';
import 'package:hlinog/ui/pages/home_page.dart';
import 'package:hlinog/ui/pages/landing_page.dart';
import 'package:hlinog/ui/pages/lesson_screen.dart';
import 'package:hlinog/ui/pages/login_page.dart';
import 'package:hlinog/ui/pages/profile_page.dart';
import 'package:hlinog/ui/pages/profile_page_edit.dart';
import 'package:hlinog/ui/pages/register_page.dart';
import 'package:hlinog/ui/pages/search_page.dart';

// Aquí ponen sus rutas o reemplazan los placeholders q puse

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
   /* '/': (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Landing'),
          ),
          body: ElevatedButton(
            child: const Text("Ir a home"),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
        ),*/
    '/':(context)=>const LandingPage(),
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
    '/search': (context) => const SearchPage(),
    '/login':(context)=> const Login(),
    '/register':(context)=>const Register(),
    '/lesson':(context)=>const LessonScreen(),
    '/profile':(context)=>const ProfilePage(),
    '/profile/edit':(context)=>const ProfilePageEdit(),
  };
}
