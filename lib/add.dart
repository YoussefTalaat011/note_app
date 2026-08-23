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
  if (titleController.text.trim().isEmpty) {
    return;
  }

  Navigator.pop(context, {
    'title': titleController.text.trim(),
    'content': contentController.text.trim(),
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Add note",
          style: TextStyle(
            color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? Colors.black,
            fontSize: Theme.of(context).appBarTheme.titleTextStyle?.fontSize ?? 32,
            fontWeight: Theme.of(context).appBarTheme.titleTextStyle?.fontWeight ?? FontWeight.bold,
          ),
        ),
        centerTitle: Theme.of(context).appBarTheme.centerTitle ?? true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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