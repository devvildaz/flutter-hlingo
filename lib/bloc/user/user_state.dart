part of 'user_bloc.dart';

enum AuthState { notAuthenticated, authenticated, checking }

@immutable
abstract class UserState {
  final AuthState state;
  final User? user;

  const UserState({this.state = AuthState.checking, this.user});
}

class UserInitialState extends UserState {
  const UserInitialState()
      : super(state: AuthState.notAuthenticated, user: null);
}

class UserSetState extends UserState {
  final User newUser;

  const UserSetState(this.newUser)
      : super(state: AuthState.authenticated, user: newUser);
}
