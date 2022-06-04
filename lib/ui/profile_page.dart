import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HoloLingo',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff1a237e),
        leading: Image.asset('assets/logo.png'),
        actions: [
          Icon(Icons.star, color: Colors.amber),
          Align(
            alignment: Alignment.center,
            child:
              Text(
                '####',
                style: TextStyle(color: Colors.white),
              ),
          ),
          SizedBox(width: 5),
          Image.asset(
            'assets/miguel.png',
            width: 30.0,
            height: 30.0,
          )
        ],
      ),
      body:
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/miguel.png',
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
          onPressed: () {},
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