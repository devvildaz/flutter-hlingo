import 'package:flutter/material.dart';
import 'package:hlingo/ui/widgets/custom_appbar.dart';

import 'package:hlingo/models/user.dart';
import 'package:hlingo/providers/user_provider.dart';

class ProfilePageEdit extends StatefulWidget {
  //const ProfilePageEdit({Key? key}) : super(key: key);

  @override
  State<ProfilePageEdit> createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  static final RegExp _letraRegExp = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  final _formKey = GlobalKey<FormState>();

  UserProvider userProvider = UserProvider();
  List<User> _userList = List<User>.empty();
  String _userId = '';
  String _userName = '';

  bool _esLetra(String str) {
    return _letraRegExp.hasMatch(str);
  }

  bool _esEmail(String str) {
    return _emailRegExp.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      'assets/profile.png',
                      width: 200.0,
                      height: 200.0,
                    ),
                  )
                ],
              ),
              Row(
                children: const [
                  Expanded(
                      child: Text(
                    'Miguel Rodriguez',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  )),
                ],
              ),
              Row(
                children: const [
                  Expanded(
                      child: Text(
                    'miguel.rodriguez@altocorreo.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )),
                ],
              ),
              const SizedBox(height: 55),
              Row(
                children: const [
                  SizedBox(width: 20),
                  SizedBox(
                      width: 350,
                      height: 20,
                      child: Text(
                        "Nombres",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                      width: 350,
                      height: 40,
                      alignment: Alignment.center,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 10,
                            bottom: 20,
                          ),
                          hintText: "Miguel Angel",
                        ),
                        validator: (value) {
                          var nombre = value.toString();
                          if (!_esLetra(nombre)) {
                            return "Solo se permiten letras";
                          }
                        },
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                ],
              ),
              const SizedBox(height: 8),
              /*Row(
                children: const [
                  SizedBox(width: 20),
                  SizedBox(
                      width: 350,
                      height: 20,
                      child: Text(
                        "Apellidos",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                      width: 350,
                      height: 40,
                      alignment: Alignment.center,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 10,
                            bottom: 20,
                          ),
                          hintText: "Rodriguez Tocas",
                        ),
                        validator: (value) {
                          var apellido = value.toString();
                          if (!_esLetra(apellido)) {
                            return "Solo se permiten letras";
                          }
                        },
                        textAlign: TextAlign.left,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      )),
                ],
              ),
              const SizedBox(height: 8),*/
              Row(
                children: const [
                  SizedBox(width: 20),
                  SizedBox(
                      width: 350,
                      height: 20,
                      child: Text(
                        "Correo Electrónico",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Row(
                children: [
                  const SizedBox(width: 20),
                  Container(
                      width: 350,
                      height: 40,
                      alignment: Alignment.center,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 10,
                            bottom: 20,
                          ),
                          hintText: "miguel.rodriguez@altocorreo.com",
                        ),
                        validator: (value) {
                          var correo = value.toString();
                          if (_esEmail(correo)) {
                            return "Ingrese un correo";
                          }
                        },
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                ],
              ),
              const SizedBox(height: 110),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 350,
                      height: 45,
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Guardando cambios ...")));
                            }

                            if (_formKey.currentState!.validate()) {
                              userProvider
                                .updateUser(_userId, _userName)
                                .then((user) => {
                                  setState(() { _userList = user; })
                              });
                            }
                          },
                          child: (const Text(
                            "Actualizar Datos",
                            style: TextStyle(fontSize: 20),
                          )),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff3949ab),
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xffededed)
      ..style = PaintingStyle.fill;
    var paint2 = Paint()
      ..color = const Color(0xff1a237e)
      ..style = PaintingStyle.fill;
    canvas.drawRect(const Offset(20, 0) & const Size(350, 20), paint1);
    canvas.drawRect(const Offset(20, 0) & const Size(220, 20), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
