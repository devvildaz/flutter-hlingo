import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/user/user_bloc.dart';

class LoginData {
  String email;
  String password;

  LoginData({
    required this.email,
    required this.password,
  });
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  final _formKey = GlobalKey<FormState>();
  final LoginData _user = LoginData(email: "", password: "");

  bool _isEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
          padding: const EdgeInsets.only(left: 24, right: 24),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 50,
                  ),
                  Image.asset('assets/main_logo.png'),
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _user.email = value;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Correo Electrónico'),
                    validator: (value) {
                      if (!_isEmail(value.toString())) {
                        return 'Ingrese un correo electrónico válido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _user.password = value;
                      });
                    },
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Ingrese una contraseña válida';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[600]),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffffffff),
                        ),
                        textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(
                                color: Colors.black, fontFamily: 'Arial')),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<UserBloc>(context, listen: false).add(
                              LoginUser(
                                  email: _user.email,
                                  password: _user.password)
                              );
                        }
                      },
                      child: BlocListener<UserBloc, UserState>(
                          listener: (context, state) {
                            if (state.userState == AuthState.authenticated) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Bienvenido'),
                                backgroundColor: Colors.green,
                              ));
                              AutoRouter.of(context).pushNamed("/home");
                            }
                            if (state.userState == AuthState.error) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Error al acceder al sistema'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
                          child: const Text('Iniciar Sesión'))),
                ],
              ),
            ),
          )),
    );
  }
}
