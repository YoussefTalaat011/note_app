import 'package:flutter/material.dart';
import 'package:flutter_project/delete.dart';
//import 'add.dart';
import 'edit.dart';

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

  // All notes
  List<Map<String, String>> notes = [];

  // Notes shown after searching
  List<Map<String, String>> filteredNotes = [];

  @override
  void initState() {
    super.initState();

    filteredNotes = notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: Theme.of(context).appBarTheme.centerTitle ?? true,
        title: const Text(
          'Notes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: const Icon(Icons.search),
              ),

              // Search by title only
              onChanged: (value) {
                setState(() {
                  filteredNotes = notes.where((note) {
                    return note['title']!.toLowerCase().contains(
                      value.toLowerCase(),
                    );
                  }).toList();
                });
              },
            ),

            const SizedBox(height: 20),

            // Notes
            Expanded(
              child: filteredNotes.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, size: 70, color: Colors.grey),
                          SizedBox(height: 15),
                          Text(
                            'No notes found',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Try searching with a different title',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      itemCount: filteredNotes.length,

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),

                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];

                        return Container(
                          decoration: BoxDecoration(
                            color: colors[index % colors.length],
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(10),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Delete Button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Edit Button
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                      ),
                                      onPressed: () async {
                                        final updatedNote =
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AddEditNoteScreen(
                                                      initialTitle:
                                                          note['title'],
                                                      intialContent:
                                                          note['content'],
                                                    ),
                                              ),
                                            );

                                        if (updatedNote != null) {
                                          setState(() {
                                            final noteIndex = notes.indexOf(
                                              note,
                                            );

                                            notes[noteIndex] =
                                                Map<String, String>.from(
                                                  updatedNote,
                                                );

                                            filteredNotes = notes;
                                          });
                                        }
                                      },
                                    ),
                                    // Delete Button
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.black,
                                      ),
                                      onPressed: () async {
                                        final shouldDelete =
                                            await showDialog<bool>(
                                              context: context,
                                              builder: (context) {
                                                return DeleteNote();
                                              },
                                            );

                                        if (shouldDelete == true) {
                                          setState(() {
                                            notes.remove(note);
                                            filteredNotes.remove(note);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),

                                // Title
                                Text(
                                  note['title']!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Content
                                Text(
                                  note['content']!,
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                ),

                                const Spacer(),

                                // Note Number
                                Text(
                                  'Note ${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white70,
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

      // Add Note Button
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final note = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEditNoteScreen()),
          );

          if (note != null) {
            setState(() {
              notes.add(Map<String, String>.from(note));

              filteredNotes = notes;
            });
          }
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
