import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/user/user_bloc.dart';
import 'package:hlingo/ui/widgets/custom_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(),
      body: Column(
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
          BlocBuilder<UserBloc, UserState>(builder: (_, state) {
            return Column(
              children: [
                Text(
                  state.user!.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                ),
                Text(
                  state.user!.email,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            );
          }),
          const SizedBox(height: 50),
          Row(children: const [
            SizedBox(width: 20),
            Text("Sesiones completadas",
                style: TextStyle(fontSize: 16, color: Colors.black))
          ]),
          Row(
            children: [
              SizedBox(
                width: 350,
                height: 20,
                child: CustomPaint(
                  painter: OpenPainter(),
                ),
              ),
            ],
          ),
          Row(children: const [
            SizedBox(width: 20),
            SizedBox(
                width: 350,
                height: 20,
                child: Text(
                  "8/12",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  textAlign: TextAlign.right,
                )),
          ]),
          const SizedBox(height: 10),
          Row(children: const [
            SizedBox(width: 20),
            Text("Puntaje Total",
                style: TextStyle(fontSize: 16, color: Colors.black))
          ]),
          Row(
            children: [
              SizedBox(
                width: 350,
                height: 20,
                child: CustomPaint(
                  painter: OpenPainter(),
                ),
              ),
            ],
          ),
          Row(children: const [
            SizedBox(width: 20),
            SizedBox(
                width: 350,
                height: 20,
                child: Text(
                  "69/128",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                  textAlign: TextAlign.right,
                )),
          ]),
          const SizedBox(height: 40),
          Row(children:  [
            SizedBox(width: 20),
            SizedBox(
                width: 350,
                height: 20,
                child:
              ElevatedButton(style:
                  ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(Colors.red[900]),foregroundColor: MaterialStateProperty.all<Color>(const Color(0xffffffff))),
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context, listen: false).add(LogoutUser());
                    Navigator.of(context).pushReplacementNamed('/');
                    }
                  , child: Text("Cerrar Sesión"))
            ),
          ]),
        ],
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, "/profile/edit"),
          backgroundColor: const Color(0xff3949ab),
          child: const Icon(Icons.border_color, color: Colors.white)),
    );
  }
}

class OpenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = const Color(0xffededed)
      ..style = PaintingStyle.fill;
    var paint2 = Paint()
      ..color = const Color(0xff1a237e)
      ..style = PaintingStyle.fill;
    canvas.drawRect(const Offset(20, 0) & const Size(350, 20), paint1);
    canvas.drawRect(const Offset(20, 0) & const Size(220, 20), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
