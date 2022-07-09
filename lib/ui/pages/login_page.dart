import 'package:flutter/material.dart';
import 'package:hlingo/models/user.dart';
import 'package:hlingo/providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  final _formKey = GlobalKey<FormState>();
  User _user = User(email: "", password: "");
  final AuthProvider authProvider = AuthProvider();

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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.loginUser(_user).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Accesando al Sistema")));
                            Navigator.pushNamed(context, "/home");
                          });
                        }
                      },
                      child: Text('Iniciar Sesión')),
                ],
              ),
            ),
          )),
    );
  }
}
