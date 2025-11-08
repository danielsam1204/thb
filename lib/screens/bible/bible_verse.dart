import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:thb/common/app_color.dart';
import '../../domain/models/bible_json_model.dart';
import '../../providers/verse_bookmark/bookmark_db.dart';
import 'bookmark_verse.dart';

class VersesPage extends StatefulWidget {
  final Chapter chapter;
  final BibleTamil book;

  const VersesPage({super.key, required this.chapter, required this.book});

  @override
  State<VersesPage> createState() => _VersesPageState();
}

class _VersesPageState extends State<VersesPage> {
  late PageController _pageController;
  late int currentIndex;
  late List<Chapter> chapters;

  final FlutterTts flutterTts = FlutterTts();
  int? currentlyPlayingIndex;
  bool isPlaying = false;
  bool isPlayingAll = false;
  double pitch = 1.0;
  double rate = 0.5;
  double zoomFactor = 1.0;

  ScrollController _scrollController = ScrollController();
  Map<int, String> bookmarkedVerses = {};

  @override
  void initState() {
    super.initState();
    chapters = widget.book.chapters ?? [];
    currentIndex = chapters.indexOf(widget.chapter);
    _pageController = PageController(initialPage: currentIndex);
    _scrollController = ScrollController();
    _loadBookmarks();
  }

  @override
  void dispose() {
    flutterTts.stop();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadBookmarks({int? index}) async {
    final bookName = widget.book.book?.tamil ?? "";
    final chapterIndex = index ?? currentIndex;
    final currentChapter = chapters[chapterIndex].chapter ?? 0;

    final data = await BookmarkDB.getBookmarks(
      bookName,
      int.tryParse(currentChapter.toString()) ?? 0,
    );

    setState(() {
      bookmarkedVerses = data;
    });
  }

  Future<void> _addBookmark(int verseNumber) async {
    final bookName = widget.book.book?.tamil ?? "";
    final currentChapter = chapters[currentIndex].chapter ?? 0;

    final selectedColor = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Select Highlight Color"),
        content: Wrap(
          spacing: 10,
          children: [
            _colorOption(Colors.yellow, "yellow"),
            _colorOption(Colors.green, "green"),
            _colorOption(Colors.blue, "blue"),
            _colorOption(Colors.pink, "pink"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await BookmarkDB.removeBookmark(bookName, int.tryParse("$currentChapter")!, verseNumber);
              Navigator.pop(context, "remove");
            },
            child: const Text("Remove Highlight"),
          ),
        ],
      ),
    );

    if (selectedColor != null && selectedColor != "remove") {
      await BookmarkDB.addBookmark(
        bookName,
        int.tryParse("$currentChapter")!,
        verseNumber,
        widget.book.chapters![currentIndex].verses![verseNumber - 1].text ?? "",
        selectedColor,
      );
      setState(() {
        bookmarkedVerses[verseNumber] = selectedColor;
      });
    } else if (selectedColor == "remove") {
      setState(() {
        bookmarkedVerses.remove(verseNumber);
      });
    }
  }

  Widget _colorOption(Color color, String name) {
    return GestureDetector(
      onTap: () => Navigator.pop(context, name),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: color,
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Color? _getHighlightColor(int verseNumber) {
    final colorName = bookmarkedVerses[verseNumber];
    switch (colorName) {
      case "yellow":
        return Colors.yellow[200];
      case "green":
        return Colors.green[200];
      case "blue":
        return Colors.blue[200];
      case "pink":
        return Colors.pink[200];
      default:
        return null;
    }
  }

  void _scrollToVerse(int verseIndex) {
    final offset = verseIndex * 60.0 - (MediaQuery.of(context).size.height / 2) + 60;
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset.clamp(0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPrevious() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToNext() {
    if (currentIndex < chapters.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _playVerse(String text, int verseIndex) async {
    await flutterTts.setLanguage("ta-IN");
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(rate);

    await flutterTts.speak(text);
    setState(() {
      currentlyPlayingIndex = verseIndex;
      isPlaying = true;
    });

    _scrollToVerse(verseIndex);

    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
        currentlyPlayingIndex = null;
      });
    });
  }

  Future<void> _playAllVerses(List verses) async {
    if (isPlayingAll) return;

    setState(() {
      isPlayingAll = true;
      currentlyPlayingIndex = 0;
    });

    await flutterTts.setLanguage("ta-IN");
    await flutterTts.setPitch(pitch);
    await flutterTts.setSpeechRate(rate);

    for (int i = 0; i < verses.length; i++) {
      if (!isPlayingAll) break;

      final verse = verses[i];
      final verseNumber = int.tryParse(verse.verse.toString()) ?? 0;
      final verseText = "$verseNumber. ${verse.text ?? ""}";

      setState(() => currentlyPlayingIndex = i);
      _scrollToVerse(i);

      await flutterTts.speak(verseText);
      await Future.delayed(const Duration(milliseconds: 300));

      bool speaking = true;
      flutterTts.setCompletionHandler(() => speaking = false);

      while (speaking && isPlayingAll) {
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }

    setState(() {
      isPlayingAll = false;
      currentlyPlayingIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalChapters = chapters.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: AppColors.lableBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Row(
                    children: [
                      Text(
                        widget.book.book?.tamil ?? "Book Name",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: _goToPrevious,
                          icon: const Icon(Icons.chevron_left, color: Colors.black)),
                      Text(
                        "${currentIndex + 1} / $totalChapters",
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      IconButton(
                          onPressed: _goToNext,
                          icon: const Icon(Icons.chevron_right, color: Colors.black)),
                      IconButton(
                        icon: Icon(
                          isPlayingAll ? Icons.stop_circle : Icons.volume_up_rounded,
                          color: AppColors.brown,
                          size: 30,
                        ),
                        onPressed: () async {
                          final currentVerses = chapters[currentIndex].verses ?? [];

                          if (isPlayingAll) {
                            await flutterTts.stop();
                            setState(() {
                              isPlayingAll = false;
                              currentlyPlayingIndex = null;
                            });
                          } else {
                            await _playAllVerses(currentVerses);
                          }
                        },
                      ),
                      IconButton(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => const BookmarkScreen()),
                            );
                            await _loadBookmarks(index: currentIndex);},
                          icon: const Icon(Icons.bookmark_border_outlined, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ),

            // 🔹 Chapters as pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) async {
                  setState(() {
                    currentIndex = index;
                    bookmarkedVerses.clear(); // clear old highlights first
                    currentlyPlayingIndex = null;
                    isPlaying = false;
                    isPlayingAll = false;
                  });

                  await _loadBookmarks(index: index);
                },
                itemCount: totalChapters,
                itemBuilder: (context, pageIndex) {
                  final verses = chapters[pageIndex].verses ?? [];

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: verses.length,
                    itemBuilder: (context, verseIndex) {
                      final verse = verses[verseIndex];
                      final verseNumber = int.tryParse(verse.verse.toString()) ?? 0;
                      final highlightColor = _getHighlightColor(verseNumber);
                      final isCurrent = currentlyPlayingIndex == verseIndex;

                      return GestureDetector(
                        onLongPress: () => _addBookmark(verseNumber),
                        child: Container(
                          color: highlightColor,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "$verseNumber ",
                                          style: TextStyle(
                                            fontSize: 16 * zoomFactor,
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: verse.text ?? "",
                                          style: TextStyle(
                                            fontSize: 15 * zoomFactor,
                                            color: Colors.black,
                                            fontWeight: isCurrent
                                                ? FontWeight.bold
                                                : FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  isCurrent && isPlaying
                                      ? Icons.stop
                                      : Icons.volume_up_rounded,
                                  color: AppColors.brown,
                                  size: 28,
                                ),
                                onPressed: () async {
                                  if (isPlayingAll) return;
                                  if (currentlyPlayingIndex == verseIndex && isPlaying) {
                                    await flutterTts.stop();
                                    setState(() {
                                      isPlaying = false;
                                      currentlyPlayingIndex = null;
                                    });
                                  } else {
                                    await _playVerse(
                                      "$verseNumber. ${verse.text ?? ""}",
                                      verseIndex,
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
