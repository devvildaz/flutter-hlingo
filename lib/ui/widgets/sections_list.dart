import 'package:flutter/material.dart';
import 'package:hlingo/models/lesson.dart';
import 'package:hlingo/providers/lessons_provider.dart';
import 'package:hlingo/ui/widgets/lesson_card.dart';

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
  List<Category> _sections = [];

  @override
  void initState() {
    super.initState();
    final lessons = LessonsProvider().getLessons();
    lessons.then((lessons) {
      if (mounted) {
        setState(() {
          _sections = _createSections(lessons);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildPanel(),
    );
  }

  List<Category> _createSections(List<Lesson> lessons) {
    final categories =
        lessons.map((lesson) => lesson.categoryName).toSet().toList();

    //group lessons by category in a list of Category objects
    final sections = categories.map((category) {
      final lessonsInCategory =
          lessons.where((lesson) => lesson.categoryName == category).toList();
      return Category(
        name: category,
        expandedValue: lessonsInCategory.map((lesson) {
          return LessonCard(
            title: lesson.title,
          );
        }).toList(),
      );
    }).toList();
    return sections;
  }

  Widget _buildPanel() {
    return FutureBuilder<List<Lesson>>(
      future: lessonsProvider.getLessons(),
      builder: (BuildContext context, AsyncSnapshot<List<Lesson>> snapshot) {
        if (snapshot.hasData) {
          return ExpansionPanelList(
            expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 8),
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _sections[index].isExpanded = !isExpanded;
              });
            },
            children: _sections.map<ExpansionPanel>((section) {
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
                  body: Container(
                    height: 130,
                    color: Colors.white,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: section.expandedValue.length,
                      itemBuilder: (context, index) {
                        return section.expandedValue[index];
                      },
                    ),
                  ),
                  isExpanded: section.isExpanded);
            }).toList(),
          );
        } else {
          return const SizedBox(
            height: 200,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
