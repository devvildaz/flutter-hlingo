import 'dart:ffi';
import 'dart:io';
import "package:flutter/material.dart";
import "package:cross_file/cross_file.dart";
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import "package:camera/camera.dart";

class CameraScreen extends StatefulWidget {
  final List<CameraDescription>? cameras;

  const CameraScreen({ Key? key, this.cameras}) : super(key: key);
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

enum WidgetState {NONE, LOADING, LOADED, ERROR}

class _CameraScreenState extends State<CameraScreen> {
  //final ImagePicker _picker = ImagePicker();
  //XFile? _video;
  // List<CameraDescription> _cameras = <CameraDescription>[];
  late CameraController _cameraController;
  bool _visible = false;
  Future<void>? _initializeControllerFuture;
  // bool _isFuturePresent = false;
  int selectedCamera = 1;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    initCamera(selectedCamera);
    super.initState();
  }
  initCamera(int cameraIdx) async {
    CameraController tempController =CameraController(widget.cameras![selectedCamera], ResolutionPreset.high);
    _cameraController = tempController;
    _initializeControllerFuture = tempController.initialize();
    Future.delayed(const Duration(seconds: 5), () { //asynchronous delay
      if (mounted) { //checks if widget is still active and not disposed
        setState(() { //tells the widget builder to rebuild again because ui has updated
          _visible=false; //update the variable declare this under your class so its accessible for both your widget build and initState which is located under widget build{}
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
      return  Center(child: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context,snapshot) {
          if(snapshot.connectionState == ConnectionState.done) {
            return Stack(
                children: [
                  CameraPreview(_cameraController),
                  const Align(
                      alignment:  Alignment(0.0, -0.8),
                      child:  InfoFloatContainer(),
                  ),
                  Align(
                    alignment: const Alignment(-0.9,0.95),
                    child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                      Navigator.of(context).pop();

                    },
                        child: const Icon(Icons.navigate_before, color: Colors.black,)
                    ),
                  ),
                  Align(
                    alignment: const Alignment(0.0, 0.95),
                    child:
                        SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child:FittedBox(
                            child:  FloatingActionButton(
                              backgroundColor: Colors.white,
                              onPressed: () {

                              },
                              child: Container(
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.red[500],
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                        )
                      )
                   ),
                ]
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }));
  }

  @override
  void dispose() {
    _cameraController.dispose();

    super.dispose();
  }

}

class InfoFloatContainer extends StatelessWidget {
  const InfoFloatContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 28,
      child: const Align(
          child : Text("Grabe un video de 20 segundos", style: TextStyle(fontStyle: FontStyle.normal, fontSize: 16)),
          alignment: Alignment.center,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: Colors.black,
            width: 1.0,
            style: BorderStyle.solid), //Border.all
        /*** The BorderRadius widget  is here ***/
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ), //BorderRadius.all
      )
    );
  }
}
