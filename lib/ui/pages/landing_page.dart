import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hlingo/ui/widgets/logo.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    const signInTxt = 'Iniciar sesión';
    const registerTxt = 'Registrarse';
    const txtStyle =
        TextStyle(fontSize: 20.0, color: Colors.white, fontFamily: 'Arial');
    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
        // primary: const Color.fromARGB(255, 255, 216, 157),
        primary: Colors.indigo[600],
        minimumSize: const Size(250, 45),
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.0)),
        ));
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.only(top: 120.0),
        child: Column(
          children: [
            const Logo(),
            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).pushNamed("/login");
                },
                style: elevatedButtonStyle,
                child: const Text(signInTxt, style: txtStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: ElevatedButton(
                onPressed: () {
                  AutoRouter.of(context).pushNamed("/register");
                },
                style: elevatedButtonStyle,
                child: const Text(registerTxt, style: txtStyle),
              ),
            )
          ],
        ),
      )),
    );
  }
}
