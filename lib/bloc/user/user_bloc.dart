import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hlingo/models/user.dart';
import 'package:hlingo/utils/constant.dart';
import 'package:hlingo/utils/user_storage.dart';
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

        if (response.statusCode == 200 || response.statusCode == 201) {
          final user = User.fromJson(json.decode(response.body));

          await UserStorage.setUserData(name: user.name, email: user.email);
          emit(UserSetState(user));
        } else {
          emit(const ErrorState('Error de inicio de sesión'));
        }
      } catch (e) {
        emit(const ErrorState("Error de inicio de sesión"));
      }
    });

    on<RegisterUser>((event, emit) async {
      emit(const LoadingState());
      try {
        final response = await http.post(Uri.parse('$baseUrl/register/email'),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'name': event.name,
              'email': event.email,
              'password': event.password,
            }));

        if (response.statusCode == 200 || response.statusCode == 201) {
          emit(const RegisteredState());
        } else {
          emit(const ErrorState('Error al registrar'));
        }
      } catch (e) {
        emit(const ErrorState("Error al registrar"));
      }
    });

    on<InitUser>(((event, emit) async {
      final userData = await UserStorage.getUserData();
      if (userData != null) {
        print("cargando datos");
        emit(UserSetState(User(
          name: userData.email,
          email: userData.name,
        )));
      } else {
        emit(const UserInitialState());
      }
    }));

    on<LogoutUser>((event, emit) async {
      await UserStorage.deleteUserData();
      Navigator.of(event.context)
          .pushReplacementNamed('/')
          .then((value) => emit(const UserInitialState()));
    });
  }
}
