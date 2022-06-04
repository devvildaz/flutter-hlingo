import 'package:flutter/material.dart';
import 'package:hlinog/ui/profile_page.dart';
import 'package:hlinog/ui/profile_page_edit.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: ProfilePageEdit(),
      ),
    );
  }
}