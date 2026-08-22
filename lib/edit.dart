import 'package:flutter/material.dart';

class AddEditNoteScreen extends StatefulWidget {
  final String? initialTitle;
  final String? intialContent;

  const AddEditNoteScreen({super.key, this.initialTitle, this.intialContent});

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  bool isEditing = false;

  late final titleController = TextEditingController(text: widget.initialTitle);
  late final contentController = TextEditingController(
    text: widget.intialContent,
  );

  void saveNote() {
  if (titleController.text.trim().isEmpty) {
    Navigator.pop(context);
    return;
  }

  Navigator.pop(context, {
    'title': titleController.text.trim(),
    'content': contentController.text.trim(),
  });
}

  @override
  Widget build(BuildContext context) {
    if (widget.initialTitle != null) {
      isEditing = true;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isEditing ? "Edit note" : "Add note",
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