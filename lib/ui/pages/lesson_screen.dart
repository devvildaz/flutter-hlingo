import "package:flutter/material.dart";
import "../widgets/lesson_icon.dart";

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key, this.lessonTitle="Buenos dias"}) : super(key: key);

  final String lessonTitle;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  minimumSize: Size(88,36)
);

class _LessonScreenState extends State<LessonScreen> {
  
  @override
  Widget build(BuildContext context) {
      
    var height = MediaQuery.of(context).viewPadding.top;

    return Container(
      margin: EdgeInsets.only(top: height),
      padding: EdgeInsets.only(top: 100), 
      color: Colors.white,
      child: Column(
        children: [
          LessonIconWidget(),
          Expanded(
            child: SizedBox(
              child: GridView.count(
                padding: const EdgeInsets.all(25),
                shrinkWrap: true,
                crossAxisCount: 1,
                childAspectRatio: 9.33 ,
                mainAxisSpacing: 10,
                children: [
                  ElevatedButton(onPressed: null, child: const Text('<text plain>')),
                  ElevatedButton(onPressed: null, child: const Text('<text plain>'))
                ]          
              ),
            ),
          ),
        ],
      ),
    );
  }
}


