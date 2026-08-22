import 'package:flutter/material.dart';

class DeleteNote extends StatelessWidget {
  const DeleteNote({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Delete Note?',
        ),
      content: Text(
        'Are you sure you want to delete this note? '
      ),
      actions: [
        TextButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed:(){
            Navigator.pop(context,true);
          },
         child: Text('Delete'),
        ),
      ],
    );
  }
}