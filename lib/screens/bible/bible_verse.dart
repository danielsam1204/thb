import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    chapters = widget.book.chapters ?? [];
    currentIndex = chapters.indexOf(widget.chapter);
    _pageController = PageController(initialPage: currentIndex);
  }

  void _goToPrevious() {
    final prevIndex =
    currentIndex > 0 ? currentIndex - 1 : chapters.length - 1;
    _pageController.animateToPage(
      prevIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => currentIndex = prevIndex);
  }

  void _goToNext() {
    final nextIndex =
    currentIndex < chapters.length - 1 ? currentIndex + 1 : 0;
    _pageController.animateToPage(
      nextIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() => currentIndex = nextIndex);
  }

  @override
  Widget build(BuildContext context) {
    final totalChapters = chapters.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Column(
        children: [
          Padding(padding: EdgeInsets.all(10),child: Container(
            decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(200)),
            color: AppColors.lableBackground,

          ),
            child: Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 5),child: Row(
              children: [
                Text(
                  widget.book.book?.tamil ?? "Book Name",
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
                Spacer(),
                IconButton(onPressed: _goToPrevious, icon: Icon(Icons.chevron_left,color: Colors.black,)),
                Text(
                  "${chapters[currentIndex].chapter} / $totalChapters",
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
                IconButton(onPressed: _goToNext, icon: Icon(Icons.chevron_right,color: Colors.black,)),
              ],
            ),)
          )),
          // Header
          // Cntainer(
          //   width: double.infinity,
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          //   decoration: BoxDecoration(
          //     color: Colors.orange[100],
          //     borderRadius: const BorderRadius.only(
          //       bottomLeft: Radius.circular(20),
          //       bottomRight: Radius.circular(20),
          //     ),
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         widget.book.book?.tamil ?? "Book Name",
          //         style: const TextStyle(
          //             fontSize: 20,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.orange),
          //       ),
          //       const SizedBox(height: 6),
          //       Text(
          //         "அதிகாரம் ${chapters[currentIndex].chapter} / $totalChapters",
          //         style: const TextStyle(fontSize: 16, color: Colors.black87),
          //       ),
          //       const SizedBox(height: 10),
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           ElevatedButton(
          //               onPressed: _goToPrevious, child: const Text("Previous")),
          //           ElevatedButton(
          //               onPressed: _goToNext, child: const Text("Next")),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),o

          // Verses PageView
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => currentIndex = index);
              },
              itemCount: chapters.length,
              itemBuilder: (context, index) {
                final verses = chapters[index].verses ?? [];
                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: verses.length,
                  itemBuilder: (context, verseIndex) {
                    final verse = verses[verseIndex];

                    // Zoom factor
                    double zoomFactor = 1.1; // adjust as needed

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "${verse.verse} ", // verse number
                                  style: TextStyle(
                                    fontSize: 16 * zoomFactor, // slightly bigger
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: "${verse.text ?? ""}", // verse text
                                  style: TextStyle(
                                    fontSize: 14 * zoomFactor, // normal base size
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold, // bold text
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Divider(color: Colors.grey),
                      ],
                    );
                  },
                );
              },
            ),
          ),

        ],
      )),
    );
  }
}
