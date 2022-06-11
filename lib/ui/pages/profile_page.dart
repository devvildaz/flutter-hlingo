import 'package:flutter/material.dart';
import 'package:hlinog/ui/widgets/appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body:
      Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/profile.png',
                  width: 200.0,
                  height: 200.0,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                    'Miguel Rodriguez',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24),
                  )
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                    'miguel.rodriguez@altocorreo.com',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
              ),
            ],
          ),
          SizedBox(height: 50),
          Row(
              children: [
                SizedBox(width: 20),
                Text(
                    "Sesiones completadas",
                    style: TextStyle(fontSize: 16, color: Colors.black)
                )
              ]
          ),
          Row(
            children: [
              Container(
                width: 350,
                height: 20,
                child: CustomPaint(
                  painter: OpenPainter(),
                ),
              ),
            ],
          ),
          Row(
              children: [
                SizedBox(width: 20),
                Container(
                    width: 350,
                    height: 20,
                    child:
                    Text(
                      "8/12",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.right,
                    )
                ),
              ]
          ),
          SizedBox(height: 10),
          Row(
              children: [
                SizedBox(width: 20),
                Text(
                    "Puntaje Total",
                    style: TextStyle(fontSize: 16, color: Colors.black)
                )
              ]
          ),
          Row(
            children: [
              Container(
                width: 350,
                height: 20,
                child: CustomPaint(
                  painter: OpenPainter(),
                ),
              ),
            ],
          ),
          Row(
              children: [
                SizedBox(width: 20),
                Container(
                    width: 350,
                    height: 20,
                    child:
                    Text(
                      "69/128",
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.right,
                    )
                ),
              ]
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, "/profile/edit"),
          backgroundColor: Color(0xff3949ab),
          child: Icon(Icons.border_color, color: Colors.white)
      ),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xffededed)
      ..style = PaintingStyle.fill;
    var paint2 = Paint()
      ..color = Color(0xff1a237e)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset(20, 0) & Size(350, 20), paint1);
    canvas.drawRect(Offset(20, 0) & Size(220, 20), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}