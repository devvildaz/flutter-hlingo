import 'package:flutter/material.dart';
import 'package:hlingo/ui/widgets/home_appbar.dart';
import 'package:hlingo/ui/widgets/sections_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HomeAppbar(),
      body: const SingleChildScrollView(child: SectionsList()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo[600],
        onPressed: () => Navigator.pushNamed(context, '/search'),
        child: const Icon(Icons.search),
      ),
    );
  }
}
