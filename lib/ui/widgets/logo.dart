import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appName = 'HoloLingo';
    const logoPath = 'assets/logo.png';
    return Column(
      children: [
        Image.asset(logoPath),
        const Text(appName, style: TextStyle(
            color: Colors.black,
            fontSize: 40.0,
            fontWeight: FontWeight.bold)
        )
      ],
    );
  }
}