import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  const LessonCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
          splashColor: Colors.amber[100],
          highlightColor: Colors.amber.withAlpha(50),
          onTap: () {
            debugPrint('Card tapped.');
          },
          child: Container(
            width: 120,
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(children: [
              Image.asset("assets/logo.png", height: 64),
              const Text("Buenos días")
            ]),
          )),
    );
  }
}
