import 'package:flutter/material.dart';
import 'package:hlinog/ui/widgets/appbar.dart';
import 'package:hlinog/ui/widgets/lesson_card.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchTerm = '';
  String? _error;
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
                    onChanged: (value) {
                      setState(() {
                        _searchTerm = value;
                      });
                    },
                    decoration: InputDecoration(
                        errorText: _error,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Lección a buscar..."),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _error = _validateSearchInput(_searchTerm);
                      });
                      if (_error != null) return;
                      // TODO: Realizar búsqueda
                    },
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
              children: const [
                LessonCard(
                  title: "a",
                ),
                LessonCard(
                  title: "a",
                ),
                LessonCard(
                  title: "a",
                )
              ],
            ),
          ],
        ));
  }

  String? _validateSearchInput(String term) {
    if (term.isEmpty) {
      return "Debe introducir un término";
    } else {
      return null;
    }
  }
}
