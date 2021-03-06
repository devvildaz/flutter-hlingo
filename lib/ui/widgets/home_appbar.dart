import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 2,
      backgroundColor: Colors.indigo[900],
      titleTextStyle: const TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
      title: Row(
        children: [
          Image.asset(
            "assets/logo.png",
            height: 42,
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: const Text("HoloLingo"),
          )
        ],
      ),
      actions: [
        const Icon(
          Icons.star,
          color: Colors.amber,
          size: 32,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: const Text(
            "36/120",
            style: TextStyle(fontSize: 16),
          ),
        ),
        IconButton(
          padding: const EdgeInsets.all(2),
          icon: Image.asset("assets/profile.png"),
          onPressed: () {
            AutoRouter.of(context).pushNamed("/profile");
          },
          tooltip: "Ir al perfil",
        ),
      ],
    );
  }
}
