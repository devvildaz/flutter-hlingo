import 'dart:ffi';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:hlingo/bloc/camera/camera_bloc.dart';
import 'package:hlingo/routes/router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessonWrapperPage extends StatefulWidget {
  const LessonWrapperPage({
    Key? key, required this.id, required this.description, this.trainVideo
  }) : super(key: key);

  final String id;
  final String description;
  final String? trainVideo;

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
  List<CameraDescription>? cameras;
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

      },
      child: AutoRouter.declarative(
          routes: (handler) {
            return [
              LessonRoute(
                  id: widget.id,
                  description: widget.description,
                  urlVideo: widget.trainVideo,
                  onNext: () {
                    setState(() {
                      currentState = LessonState.recording;
                    });
                    if(context.read<CameraBloc>().state.cameras.isEmpty){
                      context.read<CameraBloc>().add(const LoadCamerasEvent());
                    }
                  }
              ),
              if(currentState == LessonState.recording) LessonCameraRoute(
                  cameras: context.read<CameraBloc>().state.cameras,
                  onTerminate: (String videoUrl) {
                    setState(() {
                      this.videoUrl = videoUrl;
                      currentState = LessonState.videoPreview;
                    });
                  },
                  onDispose: () {

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

                  },
                  onDispose: () {

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
                  },
                  description: widget.description
              ),
            ];
          }
      )
    );
  }
}


