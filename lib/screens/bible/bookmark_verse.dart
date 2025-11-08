import 'package:flutter/material.dart';

import '../../providers/verse_bookmark/bookmark_db.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<Map<String, dynamic>> bookmarks = [];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final data = await BookmarkDB.getAllBookmarks();

    setState(() {
      bookmarks = data;
    });
  }

  Future<void> _deleteBookmark(int id) async {
    await BookmarkDB.deleteBookmark(id);
    await _loadBookmarks();

  }
  Color _getHighlightColor(String? colorName) {
    switch (colorName) {
      case "yellow":
        return Colors.yellow[200]!;
      case "green":
        return Colors.green[200]!;
      case "blue":
        return Colors.blue[200]!;
      case "pink":
        return Colors.pink[200]!;
      default:
        return Colors.white;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarked Verses"),
        actions: [
          if (bookmarks.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_forever),
              onPressed: () async {
                for (var item in bookmarks) {
                  await BookmarkDB.deleteBookmark(item['id']);
                }
                await _loadBookmarks();
              },
            )
        ],
      ),
      body: bookmarks.isEmpty
          ? const Center(child: Text("No bookmarks found"))
          : ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          final item = bookmarks[index];
          return Card(
            shadowColor: _getHighlightColor(item['color']),

            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text(
                "${item['book']} ${item['chapter']}:${item['verse']}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item['text'] ?? ""
                ,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () => _deleteBookmark(item['id']),
              ),
            ),
          );
        },
      ),
    );
  }
}
