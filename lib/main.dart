import 'package:flutter/material.dart';
import 'package:flutter_project/delete.dart';
import 'search.dart';
import 'notesList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

