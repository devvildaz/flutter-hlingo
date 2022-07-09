part of 'user_bloc.dart';

enum AuthState { notAuthenticated, authenticated, checking, error }

@immutable
abstract class UserState {
  final AuthState userState;
  final User? user;

  const UserState({this.userState = AuthState.checking, this.user});
}

class UserInitialState extends UserState {
  const UserInitialState()
      : super(userState: AuthState.notAuthenticated, user: null);
}

class UserSetState extends UserState {
  final User newUser;

  const UserSetState(this.newUser)
      : super(userState: AuthState.authenticated, user: newUser);
}

class LoadingState extends UserState {
  const LoadingState() : super(userState: AuthState.checking, user: null);
}

class RegisteredState extends UserState {
  const RegisteredState()
      : super(userState: AuthState.notAuthenticated, user: null);
}

class ErrorState extends UserState {
  final String error;

  const ErrorState(this.error) : super(userState: AuthState.error, user: null);
}
