import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class RecordingButton extends StatefulWidget {
  final Function? terminatedRecording;
  final Function? startedRecording;
  final Function? interruptRecording;
  final double duration;
  final double waitTime;
  const RecordingButton({
    Key? key,
    required this.startedRecording,
    required this.terminatedRecording,
    required this.interruptRecording,
    this.duration = 2000,
    this.waitTime = 3000,
  }) : super(key: key);

  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

enum RecordingState {
  IDLE,
  WAIT,
  RECORDING,
}

class _RecordingButtonState extends State<RecordingButton> {
  Timer? _timer;
  Timer? _waitTimer;
  RecordingState currentState = RecordingState.IDLE;
  double _start = 2000;
  double _wait = 3000;
  ValueNotifier<double> progress = ValueNotifier<double>(1);

  Future<void> startWaitTimer() async {
    setState(() {
      currentState = RecordingState.WAIT;
    });
    _timer = Timer.periodic(const Duration(milliseconds: 10),
            (Timer timer) {
          if(_wait == 0) {
            setState(() {
              _wait = widget.waitTime;
              _timer?.cancel();
              startTimer();
            });
          } else {
            setState(() {
              _wait -= 10;
              progress.value = _wait / widget.waitTime;
            });
          }
        }
    );
  }

  Future<void> startTimer() async {
    setState(() {
      currentState = RecordingState.RECORDING;
    });
    await widget.startedRecording!();
    const hundredMs = Duration(milliseconds: 10);

    _timer = Timer.periodic(hundredMs,
      (Timer timer) {
          if(_start == 0) {
            resetTimer();
            if(widget.terminatedRecording != null) widget.terminatedRecording!();
          } else {
            setState(() {
              _start -= 10;
              progress.value = _start / widget.duration;
            });
          }
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
    _waitTimer?.cancel();
  }

  resetTimer() {
    setState(() {
      progress.value = 0;
      _timer?.cancel();
      _start = widget.duration;
      currentState = RecordingState.IDLE;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(currentState) {
      case RecordingState.IDLE:
        return ElevatedButton(
            onPressed: () async {
              await startWaitTimer();
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                fixedSize: const Size(80, 80),
                shape: const CircleBorder()
            ),
            child: Container()
        );
      case RecordingState.WAIT:
        return ElevatedButton(
            onPressed: () {
              setState(() {

              });
            },
            style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                fixedSize: const Size(80, 80),
                shape: const CircleBorder()
            ),
            child: Text((_wait / 1000).ceil().toString(), style: const TextStyle(fontSize: 32),)
        );
      case RecordingState.RECORDING:
        return SizedBox(
          width: 80,
          height: 80,
          child: CustomPaint(
              size: const Size(80,80),
              painter: DashedRecordButton(progressValue: progress ),
              child: GestureDetector(
                onTap: () {
                  resetTimer();
                  if(widget.interruptRecording !=null) widget.interruptRecording!();
                },
                child: const Center(
                  child:  Icon(
                      Icons.stop,
                      size: 32,
                      color: Colors.red
                  ),
                ),
              )
          ),
        );
    }

  }
}

class DashedRecordButton extends CustomPainter {
  late ValueNotifier<double>  progress;
  DashedRecordButton({
    required ValueNotifier<double>  progressValue
  }) : super(repaint: progressValue) {
    progress =  progressValue;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width/2, size.height/2);

    final rect = Rect.fromCenter(
        center: center,
        width: size.width * 0.80,
        height: size.height * 0.80,
    );

    final rectProgress = Rect.fromCenter(
      center: center,
      width: size.width ,
      height: size.height ,
    );

    Paint paint = Paint()
      ..color = Colors.red.withOpacity(.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt
      ..strokeWidth = 10;

    Paint paintProgress = Paint()
      ..color = Colors.red.withOpacity(0.9)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    int parts = 36;
    double div = 360 / parts;
    for(int i = 0; i < parts; i+=2) {
      canvas.drawArc(
        rect,
        deg2rad(i*div),
        deg2rad(div),
        false,
        paint,
      );
    }


    canvas.drawArc(
        rectProgress,
        deg2rad(-90),
        deg2rad(360.0 * progress.value),
        false,
        paintProgress
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}

double deg2rad(double deg) => deg * math.pi / 180;

class CircularPaint extends CustomPainter {
  /// ring/border thickness, default  it will be 8px [borderThickness].
  final double borderThickness;
  final double progressValue;

  CircularPaint({
    this.borderThickness = 8.0,
    required this.progressValue,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    final rect =
    Rect.fromCenter(center: center, width: size.width, height: size.height);

    Paint paint = Paint()
      ..color = Colors.grey.withOpacity(.3)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness;

    //grey background
    canvas.drawArc(
      rect,
      deg2rad(0),
      deg2rad(360),
      false,
      paint,
    );

    Paint progressBarPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderThickness
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.purple,
          Colors.orange,
          Colors.green,
          Colors.deepOrange,
        ],
      ).createShader(rect);
    canvas.drawArc(
      rect,
      deg2rad(-90),
      deg2rad(360 * progressValue),
      false,
      progressBarPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
