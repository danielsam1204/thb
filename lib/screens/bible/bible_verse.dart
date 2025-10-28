import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:thb/common/app_color.dart';
import '../../domain/models/bible_json_model.dart';

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
  void _scrollToVerse(int verseIndex) {
    // Each item roughly has a height of 60 (adjust if needed)
    double offset = verseIndex * 60.0 - (MediaQuery.of(context).size.height / 2) + 60;
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset.clamp(0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }
  @override
  void initState() {
    super.initState();
    chapters = widget.book.chapters ?? [];
    currentIndex = chapters.indexOf(widget.chapter);
    _pageController = PageController(initialPage: currentIndex);
    _scrollController = ScrollController();


    chapters = widget.book.chapters ?? [];
    currentIndex = chapters.indexOf(widget.chapter);
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    flutterTts.stop();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _goToPrevious() {
    final prevIndex = currentIndex > 0 ? currentIndex - 1 : chapters.length - 1;
    _pageController.animateToPage(
      prevIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => currentIndex = prevIndex);
  }

  void _goToNext() {
    final nextIndex = currentIndex < chapters.length - 1 ? currentIndex + 1 : 0;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => currentIndex = nextIndex);
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

    _scrollToVerse(verseIndex); // scroll to center

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
      final verseText = "${verse.verse}. ${verse.text}";
      setState(() => currentlyPlayingIndex = i);

      _scrollToVerse(i); // scroll to center

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
            // 🔹 Header
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(200)),
                  color: AppColors.lableBackground,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Row(
                    children: [
                      Text(
                        widget.book.book?.tamil ?? "Book Name",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: _goToPrevious,
                          icon:
                          const Icon(Icons.chevron_left, color: Colors.black)),
                      Text(
                        "${chapters[currentIndex].chapter} / $totalChapters",
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black87),
                      ),
                      IconButton(
                          onPressed: _goToNext,
                          icon:
                          const Icon(Icons.chevron_right, color: Colors.black)),
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

                    ],
                  ),
                ),
              ),
            ),

            // 🔹 Verses PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemCount: chapters.length,
                itemBuilder: (context, index) {
                  final verses = chapters[index].verses ?? [];

                  return Column(
                    children: [
                      // 🔊 Play All Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [


                        ],
                      ),

                      // 🔽 Verse List
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(12),
                          itemCount: verses.length,
                          itemBuilder: (context, verseIndex) {
                            final verse = verses[verseIndex];
                            final isCurrent = currentlyPlayingIndex == verseIndex;

                            return Column(
                              children: [
                                Container(

                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      // Verse text
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 6),
                                          child: RichText(
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: "${verse.verse} ",
                                                  style: TextStyle(
                                                    fontSize: 16 * zoomFactor,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.normal,
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
                                            softWrap: true,
                                          ),
                                        ),
                                      ),

                                      // Play / Pause icon
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: IconButton(
                                          icon: Icon(
                                            isCurrent && isPlaying
                                                ? Icons.stop
                                                : Icons.volume_up_rounded,
                                            color: isCurrent && isPlaying
                                                ? AppColors.brown
                                                : AppColors.brown,
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
                                                  "${verse.verse}. ${verse.text}", verseIndex);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                  height: 12,
                                ),
                              ],
                            );
                          },
                        ),
                      ),

                    ],
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
