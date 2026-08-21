import 'package:flutter/material.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  void saveNote() {
    setState(() {
      if (titleController.text.trim().isEmpty) {
        Navigator.pop(context);
      }
    });
    // ToDo: Save note to the database
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add note",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [IconButton(onPressed: saveNote, icon: Icon(Icons.check))],
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          spacing: 30,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                hintText: "Enter title...",
                border: OutlineInputBorder(
                  borderSide: BorderSide(style: BorderStyle.solid),
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  labelText: "Content",
                  hintText: "Enter note...",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.solid),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
