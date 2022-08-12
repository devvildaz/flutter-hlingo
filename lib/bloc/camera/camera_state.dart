part of "camera_bloc.dart";

enum CamStatus {
  initial, loading, success, failure
}

class CameraState
{
  final List<CameraDescription> cameras;
  final int cameraIdxSelected;
  final CamStatus status;
  final Optional<CameraController> controller;

  const CameraState({
    this.cameras = const [],
    this.cameraIdxSelected =0,
    this.status = CamStatus.initial,
    this.controller = const Optional.empty()
  });

}
