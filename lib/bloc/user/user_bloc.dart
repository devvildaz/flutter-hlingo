import 'package:bloc/bloc.dart';
import 'package:hlingo/models/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitialState()) {
    on<LoginUser>((event, emit) {
      emit(UserSetState(event.user));
    });

    on<LogoutUser>((event, emit) => emit(const UserInitialState()));
  }
}
