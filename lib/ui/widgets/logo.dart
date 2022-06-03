import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appName = 'HoloLingo';
    const logoPath = 'images/logo.svg';
    return Column(
        children: [
          SvgPicture.asset(
              logoPath
            ),
          const Text(appName, style: TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold)
          )
        ],
    );
  }
}