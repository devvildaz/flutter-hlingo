import "package:flutter/material.dart";
import 'dart:convert';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key, this.againOption, this.returnOption, required this.result}) : super(key: key);

  final String result;
  final VoidCallback? againOption;
  final VoidCallback? returnOption;


  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late String bestSign;
  late String bestScore;

  @override
  void initState() {
    super.initState();
    Map<String,dynamic> predictions = json.decode(widget.result)['predictions'][0];
    double max = -0.1;
    String keyTarget = "<na>";
    bool ini = true;
    for(MapEntry<String, dynamic> item in predictions.entries) {
      if(max < item.value) {
        max = item.value;
        keyTarget = item.key;
      }
    }
    bestSign = keyTarget;
    bestScore = (max * 100).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 120.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              child: Text(bestSign, style: TextStyle(fontSize: 48)),
              margin: const EdgeInsets.only(bottom: 50.0),
            ),
            Container(
              child: Text(bestScore, style: TextStyle(fontSize: 56)),
              margin: const EdgeInsets.only(bottom: 50.0),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  if(widget.againOption != null) widget.againOption!();
                } ,
                icon: const Icon(Icons.arrow_back),
                label: const Text("Intentar otra vez"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if(widget.returnOption != null) widget.returnOption!();
              } ,
              icon: const Icon(Icons.home_filled),
              label: const Text("Regresar al menu"),
            ),
          ],
        ),
      ),
    );
  }
}
