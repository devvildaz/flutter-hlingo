import "package:camera/camera.dart";
import 'package:flutter/services.dart';


class CameraRepository {

  static Future<List<CameraDescription>> getCameraDescriptions() async {
    return await availableCameras();
  }

  static Future<CameraController> initializeCamera(List<CameraDescription> cameras, int idxTarget, bool audio ) async {
    CameraController controller = CameraController(cameras[idxTarget], ResolutionPreset.high, enableAudio: audio);
    await controller.initialize();
    await controller.lockCaptureOrientation(DeviceOrientation.portraitUp);
    await controller.prepareForVideoRecording();
    return controller;
  }

}