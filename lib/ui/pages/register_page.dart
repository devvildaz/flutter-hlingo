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
      backgroundColor: Colors.grey[100],
      body: Container(
        margin: EdgeInsets.only(left: 100,right: 100),
        child: Column(
          children: <Widget>[
            SizedBox(height: 25,),
            Image.asset('assets/main_logo.png'),
            SizedBox(height: 50,),
            Text('Nombres',textAlign: TextAlign.left,),
            TextField(),
            SizedBox(height: 50,),
            Text('Apellidos',textAlign: TextAlign.left,),
            TextField(),
            SizedBox(height: 50,),
            Text('Correo Electrónico',textAlign: TextAlign.left,),
            TextField(),
            SizedBox(height: 50,),
            Text('Contraseña',textAlign: TextAlign.left,),
            TextField(obscureText: true,),
            SizedBox(height: 50,),
            OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo[600]),
                  foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff),),
                  minimumSize: MaterialStateProperty.all<Size>(Size(250, 45)),
                  textStyle: MaterialStateProperty.all(TextStyle(
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