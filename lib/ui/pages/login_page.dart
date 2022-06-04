import 'dart:html';

import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 248, 252),
      body: Container(
        margin: EdgeInsets.only(left: 100,right: 100),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(height: 50,),
            Image.asset('assets/main_logo.png'),
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
                      color:Colors.black,
                      fontFamily: 'Arial')),
                ),
                onPressed: (){},
                child: Text('Iniciar Sesión')),
          ],
        ),
      ),

    );
  }

}