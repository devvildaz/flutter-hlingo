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


class RemoveCameraEvent extends CameraEvent{
  const RemoveCameraEvent(this.controller);
  final CameraController controller;
}


class SendCameraEvent extends CameraEvent {
  const SendCameraEvent(this.urlVideo);
  final String urlVideo;
}