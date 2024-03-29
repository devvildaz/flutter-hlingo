import 'package:auto_route/auto_route.dart';
import 'package:hlingo/utils/user_storage.dart';

class AuthGuard extends AutoRouteGuard {

  // recupera informacion de las credenciales o el token de inicio de sesion
  Future<bool> _isAuthenticated() async {
    final user = await UserStorage.getUserData();
    return user != null;
  }

  // Verifica si el usuario esta autenticado, en case contrario, retorna al usuario a la pagina de loginZ
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    if (await _isAuthenticated()) {
      resolver.next(true);
    } else {
      router.pushNamed("/login");
    }
  }
}
