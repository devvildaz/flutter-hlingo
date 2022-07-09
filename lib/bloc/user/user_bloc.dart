import 'package:bloc/bloc.dart';
import 'package:hlingo/models/user.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<UserEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
