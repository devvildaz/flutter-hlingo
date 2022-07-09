import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class RecordingButton extends StatefulWidget {
  final Function terminatedRecording;
  final Function startedRecording;
  const RecordingButton({
    Key? key,
    required this.startedRecording,
    required this.terminatedRecording
  }) : super(key: key);

  @override
  State<RecordingButton> createState() => _RecordingButtonState();
}

class _RecordingButtonState extends State<RecordingButton> {
  Timer? _timer;
  bool _recording = false;
  final double _duration = 2000;
  double _start = 2000;
  ValueNotifier<double> progress = ValueNotifier<double>(1);


  void startTimer() {
    const hundredMs = const Duration(milliseconds: 10);
    _timer = Timer.periodic(hundredMs,
      (Timer timer) {
          if(_start < 0) {
            setState(() {
              progress.value = 0;
              timer.cancel();
              widget.terminatedRecording();
            });
          } else {
            setState(() {
              _start -= 10;
              progress.value = _start / _duration;
            });
          }
      }
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _recording ? SizedBox(
        width: 80,
        height: 80,
        child: CustomPaint(
          size: const Size(80,80),
          painter: DashedRecorButton(progressValue: progress ),
          child: GestureDetector(
            onTap: () => {
              setState(() {
                progress.value = 1;
                _timer?.cancel();
                _start = _duration;
                _recording = false;
              })
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
    ) : ElevatedButton(

        onPressed: () {
          setState(() {
            _recording = true;
            widget.startedRecording();
            startTimer();
         });
        },
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(80, 80),
            shape: const CircleBorder()
        ),
        child: Container());
  }
}

class DashedRecorButton extends CustomPainter {
  late ValueNotifier<double>  progress;
  DashedRecorButton({
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
