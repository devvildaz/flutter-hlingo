part of "camera_bloc.dart";

@immutable
abstract class CameraState
{
  final List<CameraDescription> cameras;
  final bool isLoading;

  const CameraState({this.cameras = const [], this.isLoading = false});
}

class CameraStateInitState extends CameraState {
  const CameraStateInitState() : super();
}

class CameraStateSetState extends CameraState {
  const CameraStateSetState({ required List<CameraDescription> cameras })
      : super(cameras: cameras, isLoading: false);
}

class CameraLoadingState extends CameraState {
  const CameraLoadingState() : super(isLoading: true);
}

class CameraErrorState extends CameraState {
  final String? error;
  const CameraErrorState(this.error) : super(isLoading: false);
}