import 'package:auto_route/auto_route.dart';
import "package:flutter/material.dart";
import 'package:hlingo/bloc/camera/camera_bloc.dart';
import 'package:hlingo/routes/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonWrapperPage extends StatefulWidget {
  const LessonWrapperPage({
    Key? key, @PathParam("id") required this.id
  }) : super(key: key);

  final String id;

  @override
  State<LessonWrapperPage> createState() => _LessonWrapperPageState();
}

enum LessonState {
  mainView,
  videoPreview,
  recording,
  evaluate,
}

class _LessonWrapperPageState extends State<LessonWrapperPage> {

  late LessonState currentState;

  @override
  void initState() {
    super.initState();
    currentState = LessonState.mainView;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CameraBloc, CameraState>(
      listener: (context, state) {
        debugPrint(state.status.name);
        if(state.cameras.isEmpty) {
          debugPrint("No hay descripcion con las camaras");
        } else {
          debugPrint("Se cuenta con " + state.cameras.length.toString()+ " camara/s");
          if(state.controller.isEmpty) {
            debugPrint('La camara no esta incializada ');
            context.read<CameraBloc>().add(InitCameraEvent(state.cameras,state.cameraIdxSelected ));
          } else {
            debugPrint(state.controller.value.description.name);
          }
        }
      },
      child: AutoRouter.declarative(
          routes: (handler) {
            return [
              LessonRoute(id: widget.id),
              // if(currentState == LessonState.videoPreview) LessonCameraRoute(cameraController: cameraController)
            ];
          }
      )
    );
  }
}
