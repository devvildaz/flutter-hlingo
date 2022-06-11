import 'package:flutter/material.dart';
import 'package:hlinog/ui/widgets/appbar.dart';

class ProfilePageEdit extends StatefulWidget {
  const ProfilePageEdit({Key? key}) : super(key: key);

  @override
  State<ProfilePageEdit> createState() => _ProfilePageEditState();
}

class _ProfilePageEditState extends State<ProfilePageEdit> {
  final _formKey = GlobalKey<FormState>();
  static final RegExp _letraRegExp = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');
  static final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");

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
              children: [
                Expanded(
                    child: Text(
                  'Miguel Rodriguez',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                )),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  'miguel.rodriguez@altocorreo.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )),
              ],
            ),
            SizedBox(height: 55),
            Row(
              children: [
                SizedBox(width: 20),
                Container(
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
                SizedBox(width: 20),
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
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(width: 20),
                Container(
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
                SizedBox(width: 20),
                Container(
                    width: 350,
                    height: 40,
                    alignment: Alignment.center,
                    child: TextFormField(
                      decoration: InputDecoration(
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
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    )),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SizedBox(width: 20),
                Container(
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
                SizedBox(width: 20),
                Container(
                    width: 350,
                    height: 40,
                    alignment: Alignment.center,
                    child: TextFormField(
                      decoration: InputDecoration(
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
            SizedBox(
              height: 110,
            ),
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
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Guardando cambios ...")));
                          }
                        },
                        child: (Text(
                          "Actualizar Datos",
                          style: TextStyle(fontSize: 20),
                        )),
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff3949ab),
                        )))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xffededed)
      ..style = PaintingStyle.fill;
    var paint2 = Paint()
      ..color = Color(0xff1a237e)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(20, 0) & Size(350, 20), paint1);
    canvas.drawRect(Offset(20, 0) & Size(220, 20), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
