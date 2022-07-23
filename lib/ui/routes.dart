import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/user/user_bloc.dart';
import 'package:hlingo/ui/pages/home_page.dart';
import 'package:hlingo/ui/pages/landing_page.dart';
import 'package:hlingo/ui/pages/lesson_screen.dart';
import 'package:hlingo/ui/pages/loading_page.dart';
import 'package:hlingo/ui/pages/login_page.dart';
import 'package:hlingo/ui/pages/profile_page.dart';
import 'package:hlingo/ui/pages/profile_page_edit.dart';
import 'package:hlingo/ui/pages/register_page.dart';
import 'package:hlingo/ui/pages/search_page.dart';
import 'package:hlingo/utils/user_storage.dart';

class Routes {
  static FutureBuilder<UserData?> authRouteGuard(
      BuildContext context, Widget pageWithAuth, Widget noAuthPage) {
    return FutureBuilder(
        future: UserStorage.getUserData(),
        builder: (context, AsyncSnapshot<UserData?> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                BlocProvider.of<UserBloc>(context, listen: false)
                    .add(InitUser());
                return pageWithAuth;
              } else {
                return noAuthPage;
              }
            default:
              return const LoadingPage();
          }
        });
  }

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      '/': (context) =>
          authRouteGuard(context, const HomePage(), const LandingPage()),
      '/home': (context) => const HomePage(),
      '/search': (context) => SearchPage(),
      '/login': (context) =>
          authRouteGuard(context, const HomePage(), const LoginPage()),
      '/register': (context) => const RegisterPage(),
      '/lesson': (context) => const LessonScreen(),
      '/profile': (context) =>
          authRouteGuard(context, const ProfilePage(), const LandingPage()),
      '/profile/edit': (context) => ProfilePageEdit(),
    };
  }
}
