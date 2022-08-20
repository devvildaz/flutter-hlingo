part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class RegisterUser extends UserEvent {
  final String name;
  final String email;
  final String password;

  RegisterUser(
      {required this.name, required this.email, required this.password});
}

class LoginUser extends UserEvent {
  final String email;
  final String password;

  LoginUser({required this.email, required this.password});
}

class LogoutUser extends UserEvent {
  final BuildContext context;

  LogoutUser(this.context);
}

class InitUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final String id;
  final String name;
  final String email;
  final int score;

  UpdateUser(
      {required this.id,
      required this.name,
      required this.email,
      required this.score});
}
