import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:hlingo/bloc/camera/camera_bloc.dart';
import 'package:hlingo/models/lesson.dart';
import 'package:hlingo/routes/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/ui/pages/review_screen.dart';

class LessonWrapperPage extends StatefulWidget {
  const LessonWrapperPage({
    Key? key, required this.id
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
  late CameraController controller;
  late String videoUrl;

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
        }

        if(state.controller.isEmpty) {
          debugPrint('La camara no esta incializada ');
        } else {
          debugPrint(state.controller.value.description.name);
          setState(()  {
            debugPrint("VideoPreview");
            currentState = LessonState.recording;
            controller = state.controller.value;
          });
        }
      },
      child: AutoRouter.declarative(
          routes: (handler) {
            return [
              LessonRoute(id: widget.id),
              if(currentState == LessonState.recording) LessonCameraRoute(
                  cameraController: controller,
                  onTerminate: (String videoUrl) {
                    setState(() {
                      this.videoUrl = videoUrl;
                      currentState = LessonState.videoPreview;
                    });
                  },
                  onDispose: () {
                    context.read<CameraBloc>().add(RemoveCameraEvent(controller));
                  }
              ),
              if(currentState == LessonState.videoPreview) VideoPreviewRoute(
                  urlVideo: videoUrl,
                  onNext: () {
                    setState((){
                      currentState = LessonState.evaluate;
                    });
                  },
                  onPrev: () {
                    List<CameraDescription> cameras = context.read<CameraBloc>().state.cameras;
                    context.read<CameraBloc>().add(InitCameraEvent(cameras, 0));
                  }
              ),
              if(currentState == LessonState.evaluate) ReviewScreenRoute(
                  againOption: () {
                    setState(() {
                      currentState = LessonState.mainView;
                    });
                  },
                  returnOption: () {
                    AutoRouter.of(context).pop();
                  }
              ),
            ];
          }
      )
    );
  }
}


