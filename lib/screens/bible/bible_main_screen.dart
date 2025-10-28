import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/domain/models/bible_json_model.dart';
import 'package:thb/domain/repository/json_bible/bible_repo.dart';

import 'bible_verse.dart';

class BiblePage extends StatefulWidget {
  const BiblePage({super.key});

  @override
  State<BiblePage> createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage> {
  Map<String, BibleTamil> booksMap = {};
  int? _expandedIndex; // Track which book is expanded
  String _selectedTab = "அனைத்தும்"; // default tab
  final ScrollController _scrollController = ScrollController();

  final tabs = ["அனைத்தும்", "பழைய ஏற்பாடு ", "புதிய ஏற்பாடு "];
  List<GlobalKey> _bookKeys = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final data = await BibleRepository.loadBible();
    setState(() {
      booksMap = data;
      _bookKeys = List.generate(booksMap.length, (_) => GlobalKey());
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final booksList = booksMap.values.toList();

    // Filter books based on selected tab safely
    List<BibleTamil> filteredBooks;
    if (_selectedTab == "மழைய ஏற்றது") {
      filteredBooks = booksList.sublist(0, booksList.length >= 32 ? 32 : booksList.length);
    } else if (_selectedTab == "புதிய ஏற்றது") {
      filteredBooks = booksList.length > 32 ? booksList.sublist(32) : [];
    } else {
      filteredBooks = booksList;
    }

    return booksMap.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(

      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        title: const Text(
          "பரிசுத்த பைபிள்",
          style: TextStyle(
            color: Color(0xFF9C4D00),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.more_vert, color: Color(0xFF9C4D00)),
          ),
        ],
      ),
      body: Column(
        children: [
          // Top tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tabs.map((tab) {
                final isSelected = _selectedTab == tab;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedTab = tab;
                      _expandedIndex = null;
                    });

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF9C4D00) : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFF9C4D00)),
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF9C4D00),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 8),
          // Books list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: filteredBooks.length,
              itemBuilder: (context, index) {
                final book = filteredBooks[index];
                final isExpanded = _expandedIndex == index;

                return AnimatedContainer(
                  key: _bookKeys[index],
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Column(
                      children: [
                        // Book title
                        ListTile(
                          tileColor: AppColors.lableBackground,
                          title: Text(
                            book.book?.tamil ?? "Unknown",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF9C4D00),
                            ),
                          ),
                          trailing: Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: const Color(0xFF9C4D00),
                          ),
                          onTap: () {
                            setState(() {
                              _expandedIndex = isExpanded ? null : index;
                            });

                            // Scroll after the frame is rendered
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              final context = _bookKeys[index].currentContext;
                              if (context == null || !_scrollController.hasClients) return;

                              final box = context.findRenderObject() as RenderBox?;
                              if (box == null) return;

                              final position = box.localToGlobal(Offset.zero).dy;
                              final containerHeight = box.size.height;

                              final screenHeight = MediaQuery.of(context).size.height;

                              // Current scroll offset
                              final currentOffset = _scrollController.offset;

                              // Calculate bottom of container
                              final bottom = position + containerHeight;

                              double targetOffset = currentOffset;

                              // If bottom is beyond screen height, scroll down to show full container
                              if (bottom > screenHeight) {
                                targetOffset += bottom - screenHeight + 16; // 16 for margin/padding
                              }

                              // If top is above, scroll up (optional)
                              if (position < 0) {
                                targetOffset += position - 16; // optional top padding
                              }

                              // Clamp offset
                              targetOffset = targetOffset.clamp(
                                _scrollController.position.minScrollExtent,
                                _scrollController.position.maxScrollExtent,
                              );

                              _scrollController.animateTo(
                                targetOffset,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            });
                          },

                        ),
                        // Chapters grid
                        ClipRect(
                          child: Container(
                            color: AppColors.lableBackground,
                            child: AnimatedAlign(
                              alignment: Alignment.topCenter,
                              duration: const Duration(milliseconds: 300),
                              heightFactor: isExpanded ? 1 : 0,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: List.generate(
                                    book.chapters?.length ?? 0,
                                        (chapterIndex) {
                                      final chapter = book.chapters![chapterIndex];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => VersesPage(
                                                chapter: chapter,
                                                book: book,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: const Color(0xFF9C4D00)),
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${chapter.chapter}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Color(0xFF9C4D00),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
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
    );
  }
}
