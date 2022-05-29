import "package:flutter/material.dart";


class LessonIconWidget extends StatelessWidget {
  const LessonIconWidget({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children:[ 
          Image( 
            height: 160,
            fit: BoxFit.fill,
            image: NetworkImage("https://w7.pngwing.com/pngs/272/759/png-transparent-deaf-mute-sign-language-deaf-culture-alphabet-others-miscellaneous-white-hand.png")
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("{ Lesson Title }", style: Theme.of(context).textTheme.headline4)
          ),
      ])
    );
  }
}
