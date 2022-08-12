import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class LessonCard extends StatelessWidget {
  final String title;
  final String? imgUrl;

  const LessonCard({Key? key, required this.title, this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: InkWell(
          splashColor: Colors.indigo[100],
          highlightColor: Colors.indigo.withAlpha(50),
          onTap: () {
            debugPrint('go to lesson ' + title );
            AutoRouter.of(context).pushNamed("/lesson/");
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
              // TODO: change to imgUrl
              Image.asset("assets/logo.png", height: 64),
              Text(title)
            ]),
          )),
    );
  }
}
