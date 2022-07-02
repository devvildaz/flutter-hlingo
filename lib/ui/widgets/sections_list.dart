import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hlinog/models/lesson.dart';
import 'package:hlinog/providers/lessons_provider.dart';
import 'package:hlinog/ui/widgets/lesson_card.dart';

class Category {
  Category({
    required this.name,
    required this.expandedValue,
    this.isExpanded = false,
  });

  String name;
  List<Widget> expandedValue;
  bool isExpanded;
}

class SectionsList extends StatefulWidget {
  const SectionsList({Key? key}) : super(key: key);

  @override
  State<SectionsList> createState() => _SectionsListState();
}

class _SectionsListState extends State<SectionsList> {
  final lessonsProvider = LessonsProvider();
  late List<Category> sections;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildPanel(),
    );
  }

  Widget _buildPanel() {
    return FutureBuilder<List<Lesson>>(
      future: lessonsProvider.getLessons(),
      builder: (BuildContext context, AsyncSnapshot<List<Lesson>> snapshot) {
        if (snapshot.hasData) {
          List<Lesson> lessons = snapshot.data!;

          final categories =
              lessons.map((lesson) => lesson.categoryName).toSet().toList();

          //group lessons by category in a list of Category objects
          sections = categories.map((category) {
            final lessons_in_category = lessons
                .where((lesson) => lesson.categoryName == category)
                .toList();
            return Category(
              name: category,
              expandedValue: lessons_in_category.map((lesson) {
                return LessonCard(
                  title: lesson.title,
                );
              }).toList(),
            );
          }).toList();

          return ExpansionPanelList(
            expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 8),
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                sections[index].isExpanded = !isExpanded;
              });
            },
            children: sections.map((section) {
              return ExpansionPanel(
                  canTapOnHeader: true,
                  backgroundColor: Colors.grey[100],
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        section.name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    );
                  },
                  body: Text("a"),
                  isExpanded: section.isExpanded);
            }).toList(),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );

    // return ExpansionPanelList(
    //   expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 8),
    //   elevation: 0,
    //   expansionCallback: (int index, bool isExpanded) {
    //     setState(() {
    //       _data[index].isExpanded = !isExpanded;
    //     });
    //   },
    //   children: _data.map<ExpansionPanel>((Item item) {
    //     return ExpansionPanel(
    //       canTapOnHeader: true,
    //       backgroundColor: Colors.grey[100],
    //       headerBuilder: (BuildContext context, bool isExpanded) {
    //         return Container(
    //           alignment: Alignment.centerLeft,
    //           padding: const EdgeInsets.symmetric(horizontal: 12),
    //           child: Text(
    //             item.lesson.title,
    //             style:
    //                 const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //           ),
    //         );
    //       },
    //       body: Container(
    //           child: item.expandedValue,
    //           color: Colors.white,
    //           alignment: Alignment.center),
    //       isExpanded: item.isExpanded,
    //     );
    //   }).toList(),
    // );
  }
}
