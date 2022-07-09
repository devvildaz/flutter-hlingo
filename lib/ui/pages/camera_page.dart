
import 'package:camera_admin/components/recording_button.dart';
import 'package:camera_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({ Key? key }) : super(key: key);

  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? controller;
  bool _isCameraInitialized = false;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final CameraController cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.high,
    );

    await previousCameraController?.dispose();

    if(mounted) {
      setState(() {
        controller = cameraController;
      });
    }

    cameraController.addListener(() {
      if(mounted) setState(() {});
    });

    try {
      await cameraController.initialize();
    } on CameraException catch(e) {
      print('Error initializing camera: $e');
    }

    if(mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;
    if(cameraController == null || !cameraController.value.isInitialized){
      return;
    }
    if(state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected(cameraController.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(

        ),
        child: Center(
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                    aspectRatio: 1 / controller!.value.aspectRatio,
                    child: controller!.buildPreview()
                ),
              ),
              Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        child: const Text(
                            "Graba un fragmento de 2 segundos",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                            )
                        ),
                      )
                  ),
                  Expanded(
                      flex: 3,
                      child: Container()
                  ),
                  Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(30, 30),
                                  shape: const CircleBorder()
                                ),
                                child: const Icon(Icons.arrow_back),
                              ),
                              Spacer(),
                              RecordingButton(
                                startedRecording: () async {
                                  await controller?.prepareForVideoRecording();
                                  await controller?.startVideoRecording();
                                },
                                terminatedRecording: () async {
                                  final file = await controller?.stopVideoRecording();

                                  Navigator.pop(context, file?.path ?? 'undefined');
                                }),
                                Spacer(),
                              ],
                      )
                  )
                ],
              )
            ],
          ),
        )
    );
  }
}