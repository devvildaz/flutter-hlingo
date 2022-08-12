import "package:camera/camera.dart";


class CameraRepository {

  static Future<List<CameraDescription>> getCameraDescriptions() async {
    return await availableCameras();
  }

  static Future<CameraController> initializeCamera(List<CameraDescription> cameras, int idxTarget) async {
    CameraController controller = CameraController(cameras[idxTarget], ResolutionPreset.medium);
    await controller.initialize();
    return controller;
  }

}