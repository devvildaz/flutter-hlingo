part of 'camera_bloc.dart';

abstract class CameraEvent {
  const CameraEvent();

}

class LoadCamerasEvent extends CameraEvent {
  const LoadCamerasEvent();
}

class InitCameraEvent extends CameraEvent {
  const InitCameraEvent(this.cameras, this.idxSelected);

  final List<CameraDescription> cameras;
  final int idxSelected;
}
