import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/user/user_bloc.dart';

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
        BlocBuilder<UserBloc, UserState>(builder: (_, state) {
          if (state.user != null) {
            return Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    state.user!.score!.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(2),
                  icon: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                          color: Colors.indigo[600],
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                          child: Text(
                        state.user!.name.substring(0, 1).toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ))),
                  onPressed: () {
                    AutoRouter.of(context).pushNamed("/profile");
                  },
                  tooltip: "Ir al perfil",
                ),
              ],
            );
          } else {
            return Container();
          }
        }),
      ],
    );
  }
}
