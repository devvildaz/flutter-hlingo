import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/user/user_bloc.dart';
import 'package:hlingo/ui/widgets/custom_appbar.dart';

class ProfilePageEdit extends StatefulWidget {
  const ProfilePageEdit({Key? key}) : super(key: key);

  @override
  State<ProfilePageEdit> createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  static final RegExp _letraRegExp = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  final _formKey = GlobalKey<FormState>();

  String _userName = '';
  String _userEmail = '';

  bool _esLetra(String str) {
    return _letraRegExp.hasMatch(str);
  }

  bool _esEmail(String str) {
    return _emailRegExp.hasMatch(str);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
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
              BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                return Row(
                  children: [
                    Expanded(
                        child: Text(
                      state.user!.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                    )),
                  ],
                );
              }),
              BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                return Row(
                  children: [
                    Expanded(
                        child: Text(
                      state.user!.email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )),
                  ],
                );
              }),
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
                    child:
                        BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            left: 10,
                            bottom: 20,
                          ),
                          hintText: state.user!.name,
                        ),
                        validator: (value) {
                          var nombre = value.toString();
                          if (!_esLetra(nombre)) {
                            return "Solo se permiten letras";
                          } else if (value != null) {
                            _userName = value;
                          } else {
                            _userName = state.user!.name;
                          }
                        },
                        textAlign: TextAlign.left,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
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
                    child:
                        BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                      return TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.only(
                            left: 10,
                            bottom: 20,
                          ),
                          hintText: state.user!.email,
                        ),
                        validator: (value) {
                          var correo = value.toString();
                          if (_esEmail(correo)) {
                            return "Ingrese un correo";
                          } else if (value != null) {
                            _userEmail = value;
                          } else {
                            _userEmail = state.user!.email;
                          }
                        },
                        textAlign: TextAlign.left,
                        style:
                            const TextStyle(fontSize: 15, color: Colors.black),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(
                height: 110,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 350,
                    height: 45,
                    child:
                        BlocBuilder<UserBloc, UserState>(builder: (_, state) {
                      return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Guardando cambios ...")));
                              BlocProvider.of<UserBloc>(context).add(UpdateUser(
                                  id: state.user!.id!,
                                  email: _userEmail,
                                  name: _userName,
                                  score: state.user!.score!));
                            }
                          },
                          child: (const Text(
                            "Actualizar Datos",
                            style: TextStyle(fontSize: 20),
                          )),
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xff3949ab),
                          ));
                    }),
                  )
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
