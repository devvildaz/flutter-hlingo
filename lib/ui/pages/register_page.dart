import 'dart:html';

import 'package:flutter/material.dart';

class Register extends StatelessWidget{
  const Register({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Register',
      home: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 248, 252),
      body: Container(
        margin: EdgeInsets.only(left: 100,right: 100),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 25,),
            Image.asset('assets/main_logo.png'),
            SizedBox(height: 50,),
            Text('Nombres'),
            TextField(),
            SizedBox(height: 50,),
            Text('Apellidos'),
            TextField(),
            SizedBox(height: 50,),
            Text('Correo Electrónico'),
            TextField(),
            SizedBox(height: 50,),
            Text('Contraseña'),
            TextField(obscureText: true,),
            SizedBox(height: 50,),
            OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 33, 52, 118)),
                  minimumSize: MaterialStateProperty.all<Size>(Size(250, 45)),
                  textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                      color:Colors.white,
                      fontFamily: 'Arial')),
                ),
                onPressed: (){},
                child: Text('Registrarse')),
          ],
        ),
      ),

    );
  }

}