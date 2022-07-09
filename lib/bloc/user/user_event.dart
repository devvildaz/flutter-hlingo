part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoginUser extends UserEvent {
  final User user;

  LoginUser(this.user);
}

class LogoutUser extends UserEvent {}
