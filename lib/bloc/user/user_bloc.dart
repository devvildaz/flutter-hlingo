import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hlingo/models/user.dart';
import 'package:hlingo/utils/constant.dart';
import 'package:hlingo/utils/user_storage.dart';
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

          await UserStorage.setUserData(
              id: user.id!, name: user.name, email: user.email);
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

        if (response.statusCode == 201) {
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
        try {
          final res = await http.post(
            Uri.parse('$baseUrl/login/email'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'id': userData.id,
            }),
          );

          if (res.statusCode == 200) {
            final user = User.fromJson(json.decode(res.body));
            emit(UserSetState(user));
          } else {
            emit(const UserInitialState()); // c
          }
        } catch (e) {
          emit(const UserInitialState()); // c
        }
      } else {
        emit(const UserInitialState()); // cambiar al estado inicial
      }
    }));

    on<UpdateUser>((event, emit) async {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/user/edit'),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': event.id,
            'name': event.name,
            'email': event.email,
            'score':  double.parse((event.score).toStringAsFixed(2))
          }),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final user = User.fromJson(json.decode(response.body));

          await UserStorage.setUserData(
              id: user.id!, name: user.name, email: user.email);
          emit(UserSetState(user));
        } else {
          emit(const ErrorState('Error al actualizar'));
        }
      } catch (e) {
        emit(const ErrorState("Error al actualizar"));
      }
    });

    on<LogoutUser>((event, emit) async {
      await UserStorage
          .deleteUserData(); // eliminacion de las credenciales presentes en el local storage
      AutoRouter.of(event.context)
          .pushNamed('/') // redireccion a '/'
          .then((value) =>
              emit(const UserInitialState())); // cambio al estado inicial
    });
  }
}
