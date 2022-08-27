import 'package:auto_route/auto_route.dart';
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
          BlocBuilder<UserBloc, UserState>(builder: (_, state) {
            if (state.user != null) {
              return Column(
                children: [
                  Container(
                      width: 120,
                      height: 120,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.indigo[600],
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                          child: Text(
                        state.user!.name.substring(0, 1).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w500),
                      ))),
                  Text(
                    state.user!.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    state.user!.email,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 48),
                    child: const Text(
                      "PUNTUACIÓN",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 28, color: Colors.indigo),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 32),
                    child: Text(
                      state.user!.score.toString(),
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(fontSize: 24, color: Colors.indigo),
                    ),
                  ),
                ],
              );
            } else {
              return Container();
            }
          }),
          const SizedBox(height: 50),
          Row(children: [
            const SizedBox(width: 20),
            SizedBox(
                width: 350,
                height: 36,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[900]),
                        foregroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xffffffff))),
                    onPressed: () async {
                      BlocProvider.of<UserBloc>(context, listen: false)
                          .add(LogoutUser(context));
                    },
                    child: const Text("Cerrar Sesión"))),
          ]),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => AutoRouter.of(context).pushNamed("/profile/edit"),
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
