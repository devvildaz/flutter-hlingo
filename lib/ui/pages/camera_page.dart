import 'package:camera/camera.dart';
import "package:flutter/material.dart";

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key, required this.cameraController}) : super(key: key);

  final CameraController cameraController;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(widget.cameraController.description.name),
    );
  }
}
