import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/user/user_bloc.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({Key? key}) : super(key: key);

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
    );
  }
}
