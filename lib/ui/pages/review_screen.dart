import "package:flutter/material.dart";

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key, this.againOption, this.returnOption}) : super(key: key);

  final VoidCallback? againOption;
  final VoidCallback? returnOption;

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const ReviewScreen());
  }

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 120.0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
              child: Text("Puntaje", style: TextStyle(fontSize: 48)),
              margin: const EdgeInsets.only(bottom: 50.0),
            ),
            Container(
              child: Text("9.0", style: TextStyle(fontSize: 56)),
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
