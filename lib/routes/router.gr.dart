// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i1;
import 'package:camera/camera.dart' as _i14;
import 'package:flutter/material.dart' as _i12;

import '../ui/pages/camera_page.dart' as _i11;
import '../ui/pages/home_page.dart' as _i5;
import '../ui/pages/landing_page.dart' as _i2;
import '../ui/pages/lesson_screen.dart' as _i10;
import '../ui/pages/lesson_wrapper.dart' as _i9;
import '../ui/pages/login_page.dart' as _i3;
import '../ui/pages/profile_page.dart' as _i7;
import '../ui/pages/profile_page_edit.dart' as _i8;
import '../ui/pages/register_page.dart' as _i4;
import '../ui/pages/search_page.dart' as _i6;
import 'auth_guard.dart' as _i13;

class AppRouter extends _i1.RootStackRouter {
  AppRouter(
      {_i12.GlobalKey<_i12.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i13.AuthGuard authGuard;

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    PublicRoutes.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    PrivateRoutes.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.EmptyRouterPage());
    },
    LandingRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LandingPage());
    },
    LoginRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.LoginPage());
    },
    RegisterRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RegisterPage());
    },
    HomeRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.HomePage());
    },
    SearchRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.SearchPage());
    },
    ProfileRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.ProfilePage());
    },
    ProfileEditRoute.name: (routeData) {
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.ProfilePageEdit());
    },
    LessonWrapperRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<LessonWrapperRouteArgs>(
          orElse: () => LessonWrapperRouteArgs(id: pathParams.getString('id')));
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.LessonWrapperPage(key: args.key, id: args.id));
    },
    LessonRoute.name: (routeData) {
      final args = routeData.argsAs<LessonRouteArgs>();
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.LessonPage(key: args.key, id: args.id));
    },
    LessonCameraRoute.name: (routeData) {
      final args = routeData.argsAs<LessonCameraRouteArgs>();
      return _i1.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.CameraPage(
              key: args.key, cameraController: args.cameraController));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(PublicRoutes.name, path: '/', children: [
          _i1.RouteConfig(LandingRoute.name,
              path: '', parent: PublicRoutes.name),
          _i1.RouteConfig(LoginRoute.name,
              path: 'login', parent: PublicRoutes.name),
          _i1.RouteConfig(RegisterRoute.name,
              path: 'register', parent: PublicRoutes.name)
        ]),
        _i1.RouteConfig(PrivateRoutes.name, path: '/', guards: [
          authGuard
        ], children: [
          _i1.RouteConfig('#redirect',
              path: '',
              parent: PrivateRoutes.name,
              redirectTo: 'home',
              fullMatch: true),
          _i1.RouteConfig(HomeRoute.name,
              path: 'home', parent: PrivateRoutes.name),
          _i1.RouteConfig(SearchRoute.name,
              path: 'search', parent: PrivateRoutes.name),
          _i1.RouteConfig(ProfileRoute.name,
              path: 'profile', parent: PrivateRoutes.name),
          _i1.RouteConfig(ProfileEditRoute.name,
              path: 'profile/edit', parent: PrivateRoutes.name),
          _i1.RouteConfig(LessonWrapperRoute.name,
              path: 'lesson/:id',
              parent: PrivateRoutes.name,
              children: [
                _i1.RouteConfig(LessonRoute.name,
                    path: '', parent: LessonWrapperRoute.name),
                _i1.RouteConfig(LessonCameraRoute.name,
                    path: 'camera', parent: LessonWrapperRoute.name)
              ])
        ])
      ];
}

/// generated route for
/// [_i1.EmptyRouterPage]
class PublicRoutes extends _i1.PageRouteInfo<void> {
  const PublicRoutes({List<_i1.PageRouteInfo>? children})
      : super(PublicRoutes.name, path: '/', initialChildren: children);

  static const String name = 'PublicRoutes';
}

/// generated route for
/// [_i1.EmptyRouterPage]
class PrivateRoutes extends _i1.PageRouteInfo<void> {
  const PrivateRoutes({List<_i1.PageRouteInfo>? children})
      : super(PrivateRoutes.name, path: '/', initialChildren: children);

  static const String name = 'PrivateRoutes';
}

/// generated route for
/// [_i2.LandingPage]
class LandingRoute extends _i1.PageRouteInfo<void> {
  const LandingRoute() : super(LandingRoute.name, path: '');

  static const String name = 'LandingRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i1.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i1.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: 'register');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i1.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: 'home');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i6.SearchPage]
class SearchRoute extends _i1.PageRouteInfo<void> {
  const SearchRoute() : super(SearchRoute.name, path: 'search');

  static const String name = 'SearchRoute';
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i1.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: 'profile');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i8.ProfilePageEdit]
class ProfileEditRoute extends _i1.PageRouteInfo<void> {
  const ProfileEditRoute() : super(ProfileEditRoute.name, path: 'profile/edit');

  static const String name = 'ProfileEditRoute';
}

/// generated route for
/// [_i9.LessonWrapperPage]
class LessonWrapperRoute extends _i1.PageRouteInfo<LessonWrapperRouteArgs> {
  LessonWrapperRoute(
      {_i12.Key? key, required String id, List<_i1.PageRouteInfo>? children})
      : super(LessonWrapperRoute.name,
            path: 'lesson/:id',
            args: LessonWrapperRouteArgs(key: key, id: id),
            rawPathParams: {'id': id},
            initialChildren: children);

  static const String name = 'LessonWrapperRoute';
}

class LessonWrapperRouteArgs {
  const LessonWrapperRouteArgs({this.key, required this.id});

  final _i12.Key? key;

  final String id;

  @override
  String toString() {
    return 'LessonWrapperRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i10.LessonPage]
class LessonRoute extends _i1.PageRouteInfo<LessonRouteArgs> {
  LessonRoute({_i12.Key? key, required String id})
      : super(LessonRoute.name,
            path: '', args: LessonRouteArgs(key: key, id: id));

  static const String name = 'LessonRoute';
}

class LessonRouteArgs {
  const LessonRouteArgs({this.key, required this.id});

  final _i12.Key? key;

  final String id;

  @override
  String toString() {
    return 'LessonRouteArgs{key: $key, id: $id}';
  }
}

/// generated route for
/// [_i11.CameraPage]
class LessonCameraRoute extends _i1.PageRouteInfo<LessonCameraRouteArgs> {
  LessonCameraRoute(
      {_i12.Key? key, required _i14.CameraController cameraController})
      : super(LessonCameraRoute.name,
            path: 'camera',
            args: LessonCameraRouteArgs(
                key: key, cameraController: cameraController));

  static const String name = 'LessonCameraRoute';
}

class LessonCameraRouteArgs {
  const LessonCameraRouteArgs({this.key, required this.cameraController});

  final _i12.Key? key;

  final _i14.CameraController cameraController;

  @override
  String toString() {
    return 'LessonCameraRouteArgs{key: $key, cameraController: $cameraController}';
  }
}
