import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:hlingo/models/lesson.dart';
import 'package:hlingo/providers/lessons_provider.dart';
import 'package:hlingo/ui/widgets/custom_appbar.dart';
import 'package:hlingo/ui/widgets/lesson_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  LessonsProvider lessonsProvider = LessonsProvider();
  List<Lesson> _lessonList = List<Lesson>.empty();
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
                      lessonsProvider
                          .findLessons(_searchTerm)
                          .then((lessons) => setState(() {
                                _lessonList = lessons;
                              }));
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
                children: _lessonList
                    .asMap()
                    .entries
                    .map((lesson) => LessonCard(
                        id: lesson.value.id.oid,
                        title: lesson.value.title,
                        description: lesson.value.description)
                    )
                    .toList()),
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
