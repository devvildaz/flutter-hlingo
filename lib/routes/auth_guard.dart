import 'package:auto_route/auto_route.dart';
import 'package:hlingo/utils/user_storage.dart';

class AuthGuard extends AutoRouteGuard {
  Future<bool> _isAuthenticated() async {
    final user = await UserStorage.getUserData();

    return user != null;
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await _isAuthenticated()) {
      resolver.next(true);
    } else {
      router.pushNamed("/login");
    }
  }
}
