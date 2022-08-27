import 'package:auto_route/auto_route.dart';
import 'package:hlingo/routes/auth_guard.dart';
import 'package:hlingo/ui/pages/camera_page.dart';
import 'package:hlingo/ui/pages/home_page.dart';
import 'package:hlingo/ui/pages/landing_page.dart';
import 'package:hlingo/ui/pages/lesson_screen.dart';
import 'package:hlingo/ui/pages/lesson_wrapper.dart';
import 'package:hlingo/ui/pages/login_page.dart';
import 'package:hlingo/ui/pages/profile_page.dart';
import 'package:hlingo/ui/pages/profile_page_edit.dart';
import 'package:hlingo/ui/pages/register_page.dart';
import 'package:hlingo/ui/pages/review_screen.dart';
import 'package:hlingo/ui/pages/search_page.dart';
import 'package:hlingo/ui/pages/video_preview.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
        path: "/",
        name: "PublicRoutes",
        page: EmptyRouterPage,
        children: [
          AutoRoute(
              path: "", name: "LandingRoute", page: LandingPage, initial: true),
          AutoRoute(path: "login", name: "LoginRoute", page: LoginPage),
          AutoRoute(
              path: "register", name: "RegisterRoute", page: RegisterPage),
        ]),
    AutoRoute(
      path: "/",
      name: "PrivateRoutes",
      page: EmptyRouterPage,
      children: [
        AutoRoute(
            path: "home", name: "HomeRoute", page: HomePage, initial: true),
        AutoRoute(path: "search", name: "SearchRoute", page: SearchPage),
        AutoRoute(path: "profile", name: "ProfileRoute", page: ProfilePage),
        AutoRoute(
            path: "profile/edit",
            name: "ProfileEditRoute",
            page: ProfilePageEdit),
        AutoRoute(
            path: "lesson",
            name: "LessonWrapperRoute",
            page: LessonWrapperPage,
            children: [
              AutoRoute(path: "", name: "LessonRoute", page: LessonPage, initial: true),
              AutoRoute(path: "camera", name: "LessonCameraRoute", page: CameraPage),
              AutoRoute(path: 'preview', name: "VideoPreviewRoute", page: VideoPreview),
              AutoRoute(path: 'review', name: 'ReviewScreenRoute', page: ReviewScreen)
            ]
        ),

      ],
      guards: [AuthGuard],
    )
  ],
)
class $AppRouter {}
