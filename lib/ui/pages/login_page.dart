import 'package:flutter/material.dart';

class Login extends StatelessWidget{
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget{
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
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
        margin: const EdgeInsets.only(left: 100,right: 100),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50,),
            Image.asset('assets/main_logo.png'),
            const SizedBox(height: 50,),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico'
              ),
              validator: (value) {
                if (!_isEmail(value.toString())){
                  return 'Ingrese un correo electrónico válido';
                }
              },
            ),
            const SizedBox(height: 50,),
            TextFormField(
              decoration: const InputDecoration(
                  labelText: 'Contraseña'
              ),
              validator: (value) {
                if (value!.isEmpty){
                  return 'Ingrese una contraseña válida';
                }
              },
            ),
            const SizedBox(height: 50,),
            OutlinedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo[600]),
                  foregroundColor: MaterialStateProperty.all<Color>(const Color(0xffffffff),),
                  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                      color:Colors.black,
                      fontFamily: 'Arial')),
                ),
                onPressed: (){
                  if(_formKey.currentState!.validate()) {
                    Scaffold.of(context).showSnackBar(
                        const SnackBar(content:Text("Accesando al Sistema"))
                    );
                  }
                },
                child: Text('Iniciar Sesión')),
          ],
        ),
      ),

    );
  }

}