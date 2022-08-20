import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/camera/camera_bloc.dart';
import 'package:hlingo/main.dart';
import 'package:hlingo/ui/pages/video_preview.dart';
import 'package:hlingo/ui/widgets/recording_button.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameraController, this.onDispose, this.onTerminate}) : super(key: key);

  final VoidCallback? onDispose;
  final Function(String)? onTerminate;
  final CameraController cameraController;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  late final CameraBloc _cameraBloc;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            CameraPreview(widget.cameraController),
            Positioned.fill(
              bottom: 12,
              child: Align(
                alignment: Alignment.bottomCenter,
                  child: RecordingButton(
                      controller: widget.cameraController,
                      finishProcess: () async {
                        await widget.cameraController.stopVideoRecording();
                      },
                      startedRecording: () async {
                        await widget.cameraController.startVideoRecording();
                      },
                      terminatedRecording: () async {
                        final file = await widget.cameraController.stopVideoRecording();
                        debugPrint(file.path.toString());
                        String path = file.path.toString();
                        //Navigator.of(context).push(VideoPreview.route(path));
                        if(widget.onTerminate != null) widget.onTerminate!(path);
                      }
                  )
              )
            ),
            Positioned.fill(
                bottom: 10,
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        AutoRouter.of(context).navigateBack();
                      },
                      splashColor: Colors.red,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                        color: Colors.black,
                      ),
                    )
                )
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if(widget.onDispose != null) widget.onDispose!();
    super.dispose();
  }

}
