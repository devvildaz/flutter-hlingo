import 'package:flutter/material.dart';
import 'package:hlingo/ui/pages/home_page.dart';
import 'package:hlingo/ui/pages/landing_page.dart';
import 'package:hlingo/ui/pages/lesson_screen.dart';
import 'package:hlingo/ui/pages/login_page.dart';
import 'package:hlingo/ui/pages/profile_page.dart';
import 'package:hlingo/ui/pages/profile_page_edit.dart';
import 'package:hlingo/ui/pages/register_page.dart';
import 'package:hlingo/ui/pages/search_page.dart';

Map<String, WidgetBuilder> getRoutes() {
  return <String, WidgetBuilder>{
    '/': (context) => const LandingPage(),
    '/home': (context) => const HomePage(),
    '/search': (context) => SearchPage(),
    '/login': (context) => const LoginPage(),
    '/register': (context) => const RegisterPage(),
    '/lesson': (context) => const LessonScreen(),
    '/profile': (context) => const ProfilePage(),
    '/profile/edit': (context) => ProfilePageEdit(),
  };
}
