import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import "package:camera/camera.dart";
import 'package:optional/optional.dart';

import 'camera_repository.dart';

part 'camera_state.dart';
part 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState>{
  CameraBloc() : super(const CameraState()) {
    on<LoadCamerasEvent>((event, emit) async {
      emit(const CameraState(status: CamStatus.loading));
      try {
        List<CameraDescription> cameras = await CameraRepository.getCameraDescriptions();
        emit(CameraState(status: CamStatus.success, cameras: cameras));
      } on CameraException catch (error) {
        emit(const CameraState(status: CamStatus.failure));
      }
    });
    on<InitCameraEvent>((event, emit) async {
      var cameras = event.cameras;
      try {
        CameraController controller = await CameraRepository.initializeCamera(cameras, event.idxSelected, false);
        // print(" " + controller.description.toString());
        emit(CameraState(
            status: CamStatus.success,
            cameras: cameras,
            controller: Optional<CameraController>.of(controller),
            cameraIdxSelected: event.idxSelected ));
      } on Exception catch (e) {
        emit(const CameraState(status: CamStatus.failure));
      }
    });
    on<RemoveCameraEvent>((event, emit) async {
      List<CameraDescription> cameras = state.cameras;
      try {
        emit(const CameraState(status: CamStatus.loading));
        event.controller.dispose();
        emit(CameraState(status: CamStatus.success, cameras: cameras, controller: const Optional.empty()));
      } on Exception catch(e) {
        emit(const CameraState(status: CamStatus.failure));
      }
    });
  }
}