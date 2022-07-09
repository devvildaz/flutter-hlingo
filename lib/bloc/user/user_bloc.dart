import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:hlingo/models/user.dart';
import 'package:hlingo/utils/constant.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitialState()) {
    on<LoginUser>((event, emit) async {
      emit(const LoadingState());
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/login/email'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, String>{
            'email': event.email,
            'password': event.password,
          }),
        );

        emit(UserSetState(User.fromJson(json.decode(response.body))));
      } catch (e) {
        emit(const ErrorState("Error de inicio de sesión"));
      }
    });

    on<RegisterUser>((event, emit) async {
      emit(const LoadingState());
      try {
        await http.post(Uri.parse('$baseUrl/register/email'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'name': event.name,
              'email': event.email,
              'password': event.password,
            }));
        emit(const RegisteredState());
      } catch (e) {
        emit(const ErrorState("Error al registrar"));
      }
    });

    on<LogoutUser>((event, emit) => emit(const UserInitialState()));
  }
}
