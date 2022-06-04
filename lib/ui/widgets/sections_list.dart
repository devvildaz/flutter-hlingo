import 'package:flutter/material.dart';
import 'package:hlinog/ui/widgets/lesson_card.dart';

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  Widget expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: 'Sección ${index + 1}',
      expandedValue: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [LessonCard(), LessonCard(), LessonCard()],
      ),
    );
  });
}

class SectionsList extends StatefulWidget {
  const SectionsList({Key? key}) : super(key: key);

  @override
  State<SectionsList> createState() => _SectionsListState();
}

class _SectionsListState extends State<SectionsList> {
  final List<Item> _data = generateItems(15);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildPanel(),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expandedHeaderPadding: const EdgeInsets.symmetric(vertical: 8),
      elevation: 0,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          backgroundColor: Colors.grey[100],
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                item.headerValue,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            );
          },
          body: Container(
              child: item.expandedValue,
              color: Colors.white,
              alignment: Alignment.center),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
