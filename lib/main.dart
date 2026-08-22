import 'package:flutter/material.dart';
import 'add_edit_note_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddEditNoteScreen(
        initialTitle: "Title load placeholder",
        intialContent: "Content load placeholder",
      ),
    );
  }
}
