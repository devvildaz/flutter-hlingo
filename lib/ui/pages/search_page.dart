import 'package:flutter/material.dart';
import 'package:hlinog/ui/widgets/appbar.dart';
import 'package:hlinog/ui/widgets/lesson_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppbar(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              margin: const EdgeInsets.only(bottom: 16),
              color: Colors.grey[100],
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Ingrese la lección a buscar..."),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text("Buscar"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo[600])),
                  )
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [LessonCard(), LessonCard(), LessonCard()],
            ),
          ],
        ));
  }
}
