import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, String>> notes;

  const SearchScreen({
    super.key,
    required this.notes,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, String>> searchResults = [];

  @override
  void initState() {
    super.initState();

    searchResults = widget.notes;
  }

  void searchNotes(String value) {
    setState(() {
      if (value.trim().isEmpty) {
        searchResults = widget.notes;
      } else {
        searchResults = widget.notes.where((note) {
          final title = note['title']?.toLowerCase() ?? '';

          return title.contains(value.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: Theme.of(context).appBarTheme.centerTitle ?? true,
        title: const Text(
          'Search Notes',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            // Search Field
            TextField(
              onChanged: searchNotes,
              decoration: InputDecoration(
                hintText: 'Search by title...',
                prefixIcon: const Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 20),

            // Search Results
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(
                      child: Text(
                        'No notes found',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final note = searchResults[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(16),

                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note['title'] ?? '',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Text(
                                  note['content'] ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
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
    );
  }
}