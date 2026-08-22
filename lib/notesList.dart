import 'package:flutter/material.dart';
import 'package:flutter_project/delete.dart';
import 'add.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> colors = [
    Colors.amber.shade100,
    Colors.green.shade100,
    Colors.blue.shade100,
    Colors.orange.shade100,
    Colors.pink.shade100,
  ];

  List<Map<String, String>> notes = [];

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F3FF),
        centerTitle: true,
        title: Text(
          'Notes',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Notes Grid
            Expanded(
              child: GridView.builder(
                itemCount: notes.length,

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),

                itemBuilder: (context, index) {
                  return 
                     Container(
                      decoration: BoxDecoration(
                        color: colors[index % colors.length],
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Padding(
                        padding: EdgeInsets.all(10),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.black),
                                onPressed: () async {
                                  final shouldDelete = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return DeleteNote();
                                    },
                                  );
                              
                                  if (shouldDelete == true) {
                                    setState(() {
                                      notes.removeAt(index);
                                    });
                                  }
                                },
                              ),
                            ),
                            Text(
                              notes[index]['title']!,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              notes[index]['content']!,
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Spacer(),

                            Text(
                              'Note ${index + 1}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );

          if (note != null) {
            setState(() {
              notes.add(note);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
