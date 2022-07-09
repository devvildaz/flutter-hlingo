import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/user/user_bloc.dart';

class RegisterData {
  String name;
  String email;
  String password;

  RegisterData(
      {required this.name, required this.email, required this.password});
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final RegisterData _user = RegisterData(name: "", email: "", password: "");
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  bool _isEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 25,
                  ),
                  Image.asset("assets/main_logo.png"),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _user.name = value;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Nombre Completo'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese sus Nombres';
                      }
                    },
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
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      setState(() {
                        _user.password = value;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Contraseña'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese una contraseña';
                      }
                    },
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[600]),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffffffff),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(250, 45)),
                        textStyle: MaterialStateProperty.all(
                            const TextStyle(fontFamily: 'Arial')),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<UserBloc>(context, listen: false).add(
                              RegisterUser(
                                  name: _user.name,
                                  email: _user.email,
                                  password: _user.password));
                        }
                      },
                      child: BlocListener<UserBloc, UserState>(
                          listener: ((context, state) {
                            if (state is RegisteredState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Registro exitoso'),
                                backgroundColor: Colors.green,
                              ));

                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            }
                            if (state is ErrorState) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(state.error),
                                backgroundColor: Colors.red,
                              ));
                            }
                          }),
                          child: const Text('Registrarse')))
                ],
              ),
            ),
          )),
    );
  }
}
