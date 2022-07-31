
import 'package:camera_admin/components/recording_button.dart';
import 'package:camera_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({ Key? key }) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage>  with WidgetsBindingObserver{
  CameraController? controller;
  bool _isCameraInitialized = false;

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController? previousCameraController = controller; // capture the previous controller
    final CameraController cameraController = CameraController(
        cameraDescription, // get the camera description (metadata for the camera)
        ResolutionPreset.high, // High resolution
    );

    await previousCameraController?.dispose(); // dispose previous camera controller || release the camera's resources

    if(mounted) { // only if the component is mounted
      setState(() { // trigger a re-render
        controller = cameraController; // set the new camera controller
      });
    }

    cameraController.addListener(() { // attach a listener when the object (cameraController is changed)
      if(mounted) setState(() {}); // re-build the widget
    });

    try {
      await cameraController.initialize(); // initialize the camera
    } on CameraException catch(e) {
      print('Error initializing camera: $e'); // handling error
    }

    if(mounted) { // only component is mounted
      setState(() {
        _isCameraInitialized = controller?.value.isInitialized ?? false; //
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
    final CameraController? cameraController = controller; // get the controller
    if(cameraController == null || !cameraController.value.isInitialized){  // if null and is not initialized
      return;
    }
    if(state == AppLifecycleState.inactive) { // if state is inactive
      cameraController.dispose(); // dispose
    } else if (state == AppLifecycleState.resumed) { // if app is resumed
      onNewCameraSelected(cameraController.description); // re init the camera
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: TextStyle(

        ),
        child: Center(
          child: (controller != null && _isCameraInitialized) ?
          Stack(
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

                          RecordingButton(
                              startedRecording: () async {
                                await controller?.prepareForVideoRecording();
                                await controller?.startVideoRecording();
                              },
                              terminatedRecording: () async {
                                final file = await controller?.stopVideoRecording();

                                Navigator.pop(context, file?.path ?? "");
                              }),
                        ],
                      )
                  )
                ],
              )
            ],
          ) : const CircularProgressIndicator()
        )
    );
  }
}