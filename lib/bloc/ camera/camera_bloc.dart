import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import "package:camera/camera.dart";

part 'camera_state.dart';
part 'camera_event.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState>{
  CameraBloc() : super(const CameraStateInitState()) {
    on<LoadCamerasEvent>((event, emit) async {
      emit(const CameraLoadingState());
      try {
        List<CameraDescription> cameras = await availableCameras();
        if(cameras.isNotEmpty) {
          emit(CameraStateSetState(cameras: cameras));
        } else {
          emit(const CameraErrorState("Su equipo no cuenta con alguna camara"));
        }
      } on CameraException catch (error) {
        emit(const CameraErrorState("No se puede obtener informacion sobre la camara"));
      }
    });
git
  }
}