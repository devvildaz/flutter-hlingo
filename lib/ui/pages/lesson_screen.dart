import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:hlinog/ui/pages/camera_screen.dart';
import 'package:image_picker/image_picker.dart';
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
      padding: const EdgeInsets.only(top: 100),
      color: Colors.white,
      child: Column(
        children: [
          const LessonIconWidget(),
          Expanded(
            child: SizedBox(
              child: GridView.count(
                padding: const EdgeInsets.all(25),
                shrinkWrap: true,
                crossAxisCount: 1,
                childAspectRatio: 9.33 ,
                mainAxisSpacing: 10,
                children: [
                  ElevatedButton(onPressed: () async {
                    await availableCameras().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CameraScreen(cameras: value))
                      );
                    });
                  }, child: const Text('Practicar')),
                  ElevatedButton(onPressed: null, child: const Text('Ver video de practica'))
                ]          
              ),
            ),
          ),
        ],
      ),
    );
  }
}

