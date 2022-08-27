import 'dart:io';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:hlingo/ui/widgets/recording_button.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameras, this.onDispose, this.onTerminate}) : super(key: key);

  final List<CameraDescription> cameras;
  final VoidCallback? onDispose;
  final Function(String)? onTerminate;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  bool initializedCamera = true;
  late CameraController controller;
  int cameraIdx = 0;
  Future<void>? _initializeControllerFuture;
  AudioPlayer player = AudioPlayer();


  final String alert_audio = "assets/alert_recording.wav";

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      debugPrint("Inactive");
    } else if (state == AppLifecycleState.resumed) {
      debugPrint("resumed");
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(widget.onDispose != null) widget.onDispose!();
  }



  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[cameraIdx], ResolutionPreset.high);
    _initializeControllerFuture = initializeCamera();

  }

  Future<void> initializeCamera() async {
    if(controller.value.isInitialized) {
      await controller.dispose();
    }
    await controller.initialize();
    setState(() {
      initializedCamera = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            if(initializedCamera && _initializeControllerFuture != null) FutureBuilder(
                future: _initializeControllerFuture,
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if(snapshot.hasError) {
                    return const Center(
                      child: Text("Error con la inicializacion de la camara")
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (controller.value.isInitialized) {
                      return CameraPreview(controller);
                    } else {
                      return Container();
                    }

                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
            ),
            Positioned.fill(
              bottom: 10,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Container(),
                      ),
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: RecordingButton(
                            interruptRecording: () async {
                              await controller.stopVideoRecording();
                            } ,
                            startedRecording:() async {
                              await player.play(AssetSource("alert_recording.wav"));

                              await controller.startVideoRecording();

                            },
                            terminatedRecording:  () async {
                              final file = await controller.stopVideoRecording();
                              setState(() {
                                initializedCamera = false;
                              });
                              await controller.dispose();
                              debugPrint(file.path.toString());
                              String? path = file.path.toString();
                              if(widget.onTerminate != null) widget.onTerminate!(path);
                            }
                        )
                      ),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: RawMaterialButton(
                          onPressed: () {
                            int finalIdx;
                            CameraController newController;

                            if(cameraIdx == 0) {
                              finalIdx = 1;
                            } else {
                              finalIdx = 0;
                            }
                            newController = CameraController(widget.cameras[finalIdx], ResolutionPreset.high);
                            setState(() {
                              controller = newController;
                              _initializeControllerFuture = initializeCamera();
                              cameraIdx = finalIdx;

                            });
                          },
                          elevation: 2.0,
                          fillColor: Colors.red,
                          shape: const CircleBorder(),
                          child:const Icon(Icons.flip_camera_android, color: Colors.white),
                        ),
                      )
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }

}
