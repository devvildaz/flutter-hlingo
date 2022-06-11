import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage>{
  final _formKey = GlobalKey<FormState>();
  static final RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9\-\_]+(\.[a-zA-Z]+)*$");
  bool _isEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.only(left: 24,right: 24),
        child: Form(
          key: _formKey,
          child:Column(
          children: <Widget>[
            SizedBox(height: 25,),
            Image.asset("assets/main_logo.png"),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Nombres'
              ),
              validator: (value) {
                if (value == null||value.isEmpty){
                  return 'Ingrese sus Nombres';
                }
              },),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Apellidos'
              ),
              validator: (value) {
                if (value == null||value.isEmpty){
                  return 'Ingrese sus Apellidos';
                }
              },),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Correo Electrónico'
              ),
              validator: (value) {
                if (!_isEmail(value.toString())){
                  return 'Ingrese un correo electrónico válido';
                }
              },),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Contraseña'
              ),
              validator: (value) {
                if (value == null||value.isEmpty){
                  return 'Ingrese una contraseña';
                }
              },
              obscureText: true,),
            SizedBox(height: 50,),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo[600]),
                  foregroundColor: MaterialStateProperty.all<Color>(Color(0xffffffff),),
                  minimumSize: MaterialStateProperty.all<Size>(Size(250, 45)),
                  textStyle: MaterialStateProperty.all(TextStyle(
                      fontFamily: 'Arial')),
                ),
                onPressed: (){
                  if(_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content:Text("Registro Exitoso"))
                    );
                    Navigator.pushNamed(context, "/home");
                  }},
                child: Text('Registrarse')),
          ],
        ), )
      ),

    );
  }

}