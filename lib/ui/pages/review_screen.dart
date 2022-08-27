import "package:flutter/material.dart";
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hlingo/bloc/user/user_bloc.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({
    Key? key,
    this.againOption,
    this.returnOption,
    required this.result,
    required this.description
  }) : super(key: key);

  final String result;
  final String description;
  final VoidCallback? againOption;
  final VoidCallback? returnOption;


  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late String bestSign;
  late String bestScore;
  double value = 0;
  @override
  void initState() {
    super.initState();
    Map<String,dynamic> predictions = json.decode(widget.result)['predictions'][0];
    bestSign = widget.description;
    value = predictions[bestSign] * 100;
    bestScore = (value).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {

        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(top: 120.0),
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  child: Text("Puntaje", style: const TextStyle(fontSize: 48)),
                  margin: const EdgeInsets.only(bottom: 50.0),
                ),
                Container(
                  child: Text(bestScore, style: const TextStyle(fontSize: 56)),
                  margin: const EdgeInsets.only(bottom: 50.0),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<UserBloc>().add(UpdateUser(
                        id: state.user!.id!,
                        name: state.user!.name,
                        email: state.user!.email,
                        score: state.user!.score! + double.parse((value/20.0).toStringAsFixed(2))
                    ));
                    if(widget.againOption != null) widget.againOption!();
                  } ,
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Intentar otra vez"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<UserBloc>().add(UpdateUser(
                        id: state.user!.id!,
                        name: state.user!.name,
                        email: state.user!.email,
                        score: state.user!.score! + double.parse((value/20.0).toStringAsFixed(2))
                    ));
                    if(widget.returnOption != null) widget.returnOption!();
                  } ,
                  icon: const Icon(Icons.home_filled),
                  label: const Text("Regresar al menu"),
                ),
              ],
            ),
          );
        },
      )
        /*
      body: ,*/
    );
  }
}
