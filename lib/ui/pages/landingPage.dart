import 'package:flutter/material.dart';
import 'package:hlinog/ui/widgets/logo.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const signInTxt = 'Iniciar sesión';
    const registerTxt = 'Registrarse';
    const txtStyle = TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Arial');
    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
        // primary: const Color.fromARGB(255, 255, 216, 157),
        primary: Colors.indigo[600],
        minimumSize: const Size(250, 45),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ));
    return Center(
        child: Container(
          padding: const EdgeInsets.only(top: 250.0),
      child: Column(
        children: [
          const Logo(),
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: ElevatedButton(
              onPressed: () {},
              style: elevatedButtonStyle,
              child: const Text(signInTxt, style: txtStyle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: ElevatedButton(
              onPressed: () {},
              style: elevatedButtonStyle,
              child: const Text(registerTxt, style: txtStyle),
            ),
          )
        ],
      ),
    ));
  }
}
