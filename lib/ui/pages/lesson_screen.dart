import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import "../widgets/lesson_icon.dart";

class LessonScreen extends StatefulWidget {
  const LessonScreen({Key? key, @PathParam('id') required this.lessonTitle}) : super(key: key);

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
    debugPrint( "buildContext "+ widget.lessonTitle);
    return Container(
      margin: EdgeInsets.only(top: height),
      padding: const EdgeInsets.only(top: 100),
      color: Colors.white,
      child: Column(
        children: [
          LessonIconWidget(title: widget.lessonTitle),
          Expanded(
            child: SizedBox(
              child: GridView.count(
                padding: const EdgeInsets.all(25),
                shrinkWrap: true,
                crossAxisCount: 1,
                childAspectRatio: 9.33 ,
                mainAxisSpacing: 10,
                children: [
                  Container()
                ]          
              ),
            ),
          ),
        ],
      ),
    );
  }
}

