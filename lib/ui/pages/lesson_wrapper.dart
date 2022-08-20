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
  late String response;

  @override
  void initState() {
    super.initState();
    currentState = LessonState.mainView;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CameraBloc, CameraState>(
      listener: (context, state) {
        if(state.controller.isPresent) {
          setState(()  {
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
                  onNext: (String result) {

                    setState((){
                      response = result;
                      currentState = LessonState.evaluate;
                    });
                  },
                  onPrev: () {
                    CameraState cameraState = context.read<CameraBloc>().state;
                    List<CameraDescription> cameras = cameraState.cameras;
                    context.read<CameraBloc>().add(InitCameraEvent(cameras, cameraState.cameraIdxSelected));
                  },
                  onDispose: () {
                    CameraState cameraState = context.read<CameraBloc>().state;
                    List<CameraDescription> cameras = cameraState.cameras;
                    context.read<CameraBloc>().add(InitCameraEvent(cameras, cameraState.cameraIdxSelected));
                  }
              ),
              if(currentState == LessonState.evaluate) ReviewScreenRoute(
                  result: response,
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


