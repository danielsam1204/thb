//
// import 'package:flutter/material.dart';
// import 'package:thb/common/app_color.dart';
// import 'package:thb/domain/models/bible_json_model.dart';
// import 'package:thb/domain/repository/json_bible/bible_repo.dart';
//
// class BiblePage extends StatefulWidget {
//   const BiblePage({super.key});
//
//   @override
//   State<BiblePage> createState() => _BiblePageState();
// }
//
// class _BiblePageState extends State<BiblePage> {
//   Map<String, BibleTamil> booksMap = {};
//   int? _expandedIndex; // Track which book is expanded
//
//   @override
//   void initState() {
//     super.initState();
//     _loadBooks();
//   }
//
//   Future<void> _loadBooks() async {
//     final data = await BibleRepository.loadBible();
//     setState(() {
//       booksMap = data;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (booksMap.isEmpty) {
//       return  Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     final booksList = booksMap.values.toList();
//
//     return Scaffold( backgroundColor: Colors.white,
//       appBar: AppBar(title: const Text("Bible Books")),
//       body: Column(
//         children: [
//           Expanded(child: ListView.builder(
//             itemCount: booksList.length,
//             itemBuilder: (context, index) {
//               final book = booksList[index];
//               final isExpanded = _expandedIndex == index;
//
//               return AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: Card(
//                   child: Column(
//                     children: [
//                       ListTile(
//
//                         title: Text(
//                           book.book?.tamil ?? "Unknown" +  "/" + "${book.book?.english ?? ""}  ",
//                           style: const TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(book.book?.english ?? ""),
//                         trailing: Icon(
//                           isExpanded
//                               ? Icons.keyboard_arrow_up
//                               : Icons.keyboard_arrow_down,
//                         ),
//                         onTap: () {
//                           setState(() {
//                             _expandedIndex = isExpanded ? null : index;
//                           });
//                         },
//                       ),
//                       // Expanded chapter list
//                       ClipRect(
//                         child: AnimatedAlign(
//                           alignment: Alignment.topCenter,
//                           duration: const Duration(milliseconds: 300),
//                           heightFactor: isExpanded ? 1 : 0,
//                           child: Column(
//                             children: [
//                               ClipRect(
//                                 child: AnimatedAlign(
//                                   alignment: Alignment.topCenter,
//                                   duration: const Duration(milliseconds: 300),
//                                   heightFactor: isExpanded ? 1 : 0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                                     child: Wrap(
//                                       spacing: 8, // horizontal spacing
//                                       runSpacing: 8, // vertical spacing
//                                       children: List.generate(book.chapters?.length ?? 0, (chapterIndex) {
//                                         final chapter = book.chapters![chapterIndex];
//                                         return GestureDetector(
//                                           onTap: () {
//                                             // Navigator.push(
//                                             //   context,
//                                             //   MaterialPageRoute(
//                                             //     builder: (context) => VersesPage(
//                                             //       chapter: chapter,
//                                             //       book: book,
//                                             //     ),
//                                             //   ),
//                                             // );
//                                           },
//                                           child: Container(
//                                             width: 50, // fixed width
//                                             height: 50, // fixed height
//
//                                             decoration: BoxDecoration(
//                                               border: Border.all(color: AppColors.brown),
//                                               color: Colors.transparent,
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                             alignment: Alignment.center, // center text inside
//                                             child: Text(
//                                               "${chapter.chapter}",
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold, fontSize: 16),
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),)
//         ],
//       )
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/domain/models/bible_json_model.dart';
import 'package:thb/domain/repository/json_bible/bible_repo.dart';
import 'package:thb/screens/home/widgets/posters_widget.dart';
import 'package:thb/widgets/custom_app_bar.dart';
import 'package:thb/widgets/custom_tab_bar.dart';

import 'bible_verse.dart';

class BiblePage extends StatefulWidget {
  const BiblePage({super.key});

  @override
  State<BiblePage> createState() => _BiblePageState();
}

class _BiblePageState extends State<BiblePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  Map<String, BibleTamil> booksMap = {};
  int? _expandedIndex; // Track which book is expanded
  String _selectedTab = "அனைத்தும்"; // default tab
  final ScrollController _scrollController = ScrollController();

  final tabs = ["அனைத்தும்", "பழைய ஏற்பாடு", "புதிய ஏற்பாடு"];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    final data = await BibleRepository.loadBible();
    setState(() {
      booksMap = data;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (booksMap.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final booksList = booksMap.values.toList();

    // Filter books based on selected tab safely
    List<BibleTamil> filteredBooks;
    if (_selectedTab == "பழைய ஏற்பாடு") {
      filteredBooks = booksList.sublist(
        0,
        booksList.length >= 32 ? 32 : booksList.length,
      );
    } else if (_selectedTab == "புதிய ஏற்பாடு") {
      filteredBooks = booksList.length > 32 ? booksList.sublist(32) : [];
    } else {
      filteredBooks = booksList;
    }

    return Scaffold(
      // backgroundColor: const Color(0xFFFFF8F0),
      appBar: CustomAppbar(title: "பரிசுத்த பைபிள்"),
      // AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Color(0xFF9C4D00)),
      //     onPressed: () {},
      //   ),
      //   title: const Text(
      //     "பரிசுத்த பைபிள்",
      //     style: TextStyle(color: Color(0xFF9C4D00), fontWeight: FontWeight.bold),
      //   ),
      //   actions: const [
      //     Padding(
      //       padding: EdgeInsets.only(right: 12.0),
      //       child: Icon(Icons.more_vert, color: Color(0xFF9C4D00)),
      //     ),
      //   ],
      // ),
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

                    // Scroll to top when tab changes
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF9C4D00)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: const Color(0xFF9C4D00)),
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF9C4D00),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 8),
          // Books list with animation
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (child, animation) {
                final offsetAnimation = Tween<Offset>(
                  begin: const Offset(0, 0.1),
                  end: Offset.zero,
                ).animate(animation);
                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: ListView.builder(
                key: ValueKey(_selectedTab), // important for AnimatedSwitcher
                controller: _scrollController,
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final book = filteredBooks[index];
                  final isExpanded = _expandedIndex == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
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

                              // Auto scroll to make expanded book fully visible
                              if (!isExpanded) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  final renderBox =
                                      context.findRenderObject() as RenderBox?;
                                  if (renderBox != null) {
                                    final position = renderBox.localToGlobal(
                                      Offset.zero,
                                    );
                                    final offset =
                                        _scrollController.offset +
                                        position.dy -
                                        100;
                                    _scrollController.animateTo(
                                      offset,
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                });
                              }
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
                                        final chapter =
                                            book.chapters![chapterIndex];
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    VersesPage(
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
                                              border: Border.all(
                                                color: const Color(0xFF9C4D00),
                                              ),
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
          ),
        ],
      ),
    );
  }
}

//
// import 'package:flutter/material.dart';
// import 'package:thb/common/app_color.dart';
// import 'package:thb/domain/models/bible_json_model.dart';
// import 'package:thb/domain/repository/json_bible/bible_repo.dart';
//
// class BiblePage extends StatefulWidget {
//   const BiblePage({super.key});
//
//   @override
//   State<BiblePage> createState() => _BiblePageState();
// }
//
// class _BiblePageState extends State<BiblePage> {
//   Map<String, BibleTamil> booksMap = {};
//   int? _expandedIndex; // Track which book is expanded
//
//   @override
//   void initState() {
//     super.initState();
//     _loadBooks();
//   }
//
//   Future<void> _loadBooks() async {
//     final data = await BibleRepository.loadBible();
//     setState(() {
//       booksMap = data;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (booksMap.isEmpty) {
//       return  Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(child: CircularProgressIndicator()),
//       );
//     }
//
//     final booksList = booksMap.values.toList();
//
//     return Scaffold( backgroundColor: Colors.white,
//       appBar: AppBar(title: const Text("Bible Books")),
//       body: Column(
//         children: [
//           Expanded(child: ListView.builder(
//             itemCount: booksList.length,
//             itemBuilder: (context, index) {
//               final book = booksList[index];
//               final isExpanded = _expandedIndex == index;
//
//               return AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 curve: Curves.easeInOut,
//                 margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                 child: Card(
//                   child: Column(
//                     children: [
//                       ListTile(
//
//                         title: Text(
//                           book.book?.tamil ?? "Unknown" +  "/" + "${book.book?.english ?? ""}  ",
//                           style: const TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.bold),
//                         ),
//                         subtitle: Text(book.book?.english ?? ""),
//                         trailing: Icon(
//                           isExpanded
//                               ? Icons.keyboard_arrow_up
//                               : Icons.keyboard_arrow_down,
//                         ),
//                         onTap: () {
//                           setState(() {
//                             _expandedIndex = isExpanded ? null : index;
//                           });
//                         },
//                       ),
//                       // Expanded chapter list
//                       ClipRect(
//                         child: AnimatedAlign(
//                           alignment: Alignment.topCenter,
//                           duration: const Duration(milliseconds: 300),
//                           heightFactor: isExpanded ? 1 : 0,
//                           child: Column(
//                             children: [
//                               ClipRect(
//                                 child: AnimatedAlign(
//                                   alignment: Alignment.topCenter,
//                                   duration: const Duration(milliseconds: 300),
//                                   heightFactor: isExpanded ? 1 : 0,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                                     child: Wrap(
//                                       spacing: 8, // horizontal spacing
//                                       runSpacing: 8, // vertical spacing
//                                       children: List.generate(book.chapters?.length ?? 0, (chapterIndex) {
//                                         final chapter = book.chapters![chapterIndex];
//                                         return GestureDetector(
//                                           onTap: () {
//                                             // Navigator.push(
//                                             //   context,
//                                             //   MaterialPageRoute(
//                                             //     builder: (context) => VersesPage(
//                                             //       chapter: chapter,
//                                             //       book: book,
//                                             //     ),
//                                             //   ),
//                                             // );
//                                           },
//                                           child: Container(
//                                             width: 50, // fixed width
//                                             height: 50, // fixed height
//
//                                             decoration: BoxDecoration(
//                                               border: Border.all(color: AppColors.brown),
//                                               color: Colors.transparent,
//                                               borderRadius: BorderRadius.circular(8),
//                                             ),
//                                             alignment: Alignment.center, // center text inside
//                                             child: Text(
//                                               "${chapter.chapter}",
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.bold, fontSize: 16),
//                                             ),
//                                           ),
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),)
//         ],
//       )
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:thb/common/app_color.dart';
// import 'package:thb/domain/models/bible_json_model.dart';
// import 'package:thb/domain/repository/json_bible/bible_repo.dart';
// import 'package:thb/screens/home/widgets/posters_widget.dart';
// import 'package:thb/widgets/custom_app_bar.dart';
// import 'package:thb/widgets/custom_tab_bar.dart';
//
// import 'bible_verse.dart';
//
// class BiblePage extends StatefulWidget {
//   const BiblePage({super.key});
//
//   @override
//   State<BiblePage> createState() => _BiblePageState();
// }
//
// class _BiblePageState extends State<BiblePage>
//     with SingleTickerProviderStateMixin {
//   late TabController tabController;
//   Map<String, BibleTamil> booksMap = {};
//   List<BibleTamil> filteredBooks = [];
//   int? _expandedIndex; // Track which book is expanded
//   // String _selectedTab = "அனைத்தும்"; // default tab
//   final ScrollController _scrollController = ScrollController();
//
//   final tabs = ["அனைத்தும்", "பழைய ஏற்பாடு", "புதிய ஏற்பாடு"];
//
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 3, vsync: this);
//     tabController.addListener(tabListener);
//     _loadBooks();
//   }
//
//   void tabListener() {
//     if (!tabController.indexIsChanging) {
//       filteredBooks = [];
//       final booksList = booksMap.values.toList();
//       print(booksList.length);
//       Logger().d(booksList);
//       if (tabController.index == 0) {
//         filteredBooks = booksList;
//       } else if (tabController.index == 1) {
//         filteredBooks = booksMap.values.toList().sublist(
//           0,
//           booksList.length >= 32 ? 32 : booksList.length,
//         );
//       } else {
//         filteredBooks = booksMap.values.toList().sublist(
//           0,
//           booksList.length >= 32 ? 32 : booksList.length,
//         );
//       }
//       setState(() {});
//     }
//   }
//
//   Future<void> _loadBooks() async {
//     final data = await BibleRepository.loadBible();
//     Logger().i(data);
//     setState(() {
//       // booksMap = data;
//       filteredBooks = data.entries.map((entry) {
//         return entry.value;
//       }).toList();
//     });
//   }
//
//   @override
//   void dispose() {
//     tabController.dispose();
//     _scrollController.dispose();
//     tabController.removeListener(tabListener);
//     super.dispose();
//   }
//
//   // final booksList = booksMap.values.toList();
//   // List<BibleTamil> filteredBooks;
//   // if (_selectedTab == "பழைய ஏற்பாடு") {
//   // filteredBooks = booksMap.values.toList().sublist(
//   // 0,
//   // booksList.length >= 32 ? 32 : booksList.length,
//   // );
//   // } else if (_selectedTab == "புதிய ஏற்பாடு") {
//   // filteredBooks = booksList.length > 32 ? booksList.sublist(32) : [];
//   // } else {
//   // filteredBooks = booksList;
//   // }
//   @override
//   Widget build(BuildContext context) {
//     // if (booksMap.isEmpty) {
//     //   return Scaffold(
//     //     backgroundColor: Colors.white,
//     //     body: const Center(child: CircularProgressIndicator()),
//     //   );
//     // }
//
//     // Filter books based on selected tab safely
//
//     return Scaffold(
//       // backgroundColor: const Color(0xFFFFF8F0),
//       appBar: CustomAppbar(title: "பரிசுத்த பைபிள்"),
//       // AppBar(
//       //   backgroundColor: Colors.white,
//       //   elevation: 0,
//       //   leading: IconButton(
//       //     icon: const Icon(Icons.arrow_back, color: Color(0xFF9C4D00)),
//       //     onPressed: () {},
//       //   ),
//       //   title: const Text(
//       //     "பரிசுத்த பைபிள்",
//       //     style: TextStyle(color: Color(0xFF9C4D00), fontWeight: FontWeight.bold),
//       //   ),
//       //   actions: const [
//       //     Padding(
//       //       padding: EdgeInsets.only(right: 12.0),
//       //       child: Icon(Icons.more_vert, color: Color(0xFF9C4D00)),
//       //     ),
//       //   ],
//       // ),
//       body: Column(
//         children: [
//           // Top tabs
//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//           //     children: tabs.map((tab) {
//           //       final isSelected = _selectedTab == tab;
//           //       return GestureDetector(
//           //         onTap: () {
//           //           setState(() {
//           //             _selectedTab = tab;
//           //             _expandedIndex = null;
//           //           });
//           //
//           //           // Scroll to top when tab changes
//           //           WidgetsBinding.instance.addPostFrameCallback((_) {
//           //             _scrollController.animateTo(
//           //               0,
//           //               duration: const Duration(milliseconds: 300),
//           //               curve: Curves.easeInOut,
//           //             );
//           //           });
//           //         },
//           //         child: Container(
//           //           padding: const EdgeInsets.symmetric(
//           //             horizontal: 16,
//           //             vertical: 8,
//           //           ),
//           //           decoration: BoxDecoration(
//           //             color: isSelected
//           //                 ? const Color(0xFF9C4D00)
//           //                 : Colors.white,
//           //             borderRadius: BorderRadius.circular(30),
//           //             border: Border.all(color: const Color(0xFF9C4D00)),
//           //           ),
//           //           child: Text(
//           //             tab,
//           //             style: TextStyle(
//           //               color: isSelected
//           //                   ? Colors.white
//           //                   : const Color(0xFF9C4D00),
//           //               fontWeight: FontWeight.bold,
//           //             ),
//           //           ),
//           //         ),
//           //       );
//           //     }).toList(),
//           //   ),
//           // ),
//           CustomTabBar(
//             controller: tabController,
//             tabs: [
//               customOptionCard(label: "அனைத்தும்"),
//               customOptionCard(label: "பழைய ஏற்பாடு"),
//               customOptionCard(label: "புதிய ஏற்பாடு"),
//             ],
//             onTap: (int i) {
//               setState(() {
//                 // _selectedTab = tab;
//                 _expandedIndex = null;
//               });
//
//               // Scroll to top when tab changes
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 _scrollController.animateTo(
//                   0,
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                 );
//               });
//             },
//           ),
//           const SizedBox(height: 8),
//           // Books list with animation
//           Expanded(
//             child: AnimatedSwitcher(
//               duration: const Duration(milliseconds: 400),
//               transitionBuilder: (child, animation) {
//                 final offsetAnimation = Tween<Offset>(
//                   begin: const Offset(0, 0.1),
//                   end: Offset.zero,
//                 ).animate(animation);
//                 return SlideTransition(
//                   position: offsetAnimation,
//                   child: FadeTransition(opacity: animation, child: child),
//                 );
//               },
//               child: ListView.builder(
//                 // key: ValueKey(_selectedTab), // important for AnimatedSwitcher
//                 controller: _scrollController,
//                 itemCount: filteredBooks.length,
//                 itemBuilder: (context, index) {
//                   final book = filteredBooks[index];
//                   final isExpanded = _expandedIndex == index;
//
//                   return AnimatedContainer(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                     margin: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 6,
//                     ),
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(16),
//                       ),
//                       elevation: 3,
//                       child: Column(
//                         children: [
//                           // Book title
//                           ListTile(
//                             tileColor: AppColors.lableBackground,
//                             title: Text(
//                               book.book?.tamil ?? "Unknown",
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color(0xFF9C4D00),
//                               ),
//                             ),
//                             trailing: Icon(
//                               isExpanded
//                                   ? Icons.keyboard_arrow_up
//                                   : Icons.keyboard_arrow_down,
//                               color: const Color(0xFF9C4D00),
//                             ),
//                             onTap: () {
//                               setState(() {
//                                 _expandedIndex = isExpanded ? null : index;
//                               });
//
//                               // Auto scroll to make expanded book fully visible
//                               if (!isExpanded) {
//                                 WidgetsBinding.instance.addPostFrameCallback((
//                                     _,
//                                     ) {
//                                   final renderBox =
//                                   context.findRenderObject() as RenderBox?;
//                                   if (renderBox != null) {
//                                     final position = renderBox.localToGlobal(
//                                       Offset.zero,
//                                     );
//                                     final offset =
//                                         _scrollController.offset +
//                                             position.dy -
//                                             100;
//                                     _scrollController.animateTo(
//                                       offset,
//                                       duration: const Duration(
//                                         milliseconds: 300,
//                                       ),
//                                       curve: Curves.easeInOut,
//                                     );
//                                   }
//                                 });
//                               }
//                             },
//                           ),
//
//                           // Chapters grid
//                           ClipRect(
//                             child: Container(
//                               color: AppColors.lableBackground,
//                               child: AnimatedAlign(
//                                 alignment: Alignment.topCenter,
//                                 duration: const Duration(milliseconds: 300),
//                                 heightFactor: isExpanded ? 1 : 0,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: Wrap(
//                                     spacing: 8,
//                                     runSpacing: 8,
//                                     children: List.generate(
//                                       book.chapters?.length ?? 0,
//                                           (chapterIndex) {
//                                         final chapter =
//                                         book.chapters![chapterIndex];
//                                         return GestureDetector(
//                                           onTap: () {
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     VersesPage(
//                                                       chapter: chapter,
//                                                       book: book,
//                                                     ),
//                                               ),
//                                             );
//                                           },
//                                           child: Container(
//                                             width: 50,
//                                             height: 50,
//                                             decoration: BoxDecoration(
//                                               border: Border.all(
//                                                 color: const Color(0xFF9C4D00),
//                                               ),
//                                               color: Colors.transparent,
//                                               borderRadius:
//                                               BorderRadius.circular(8),
//                                             ),
//                                             alignment: Alignment.center,
//                                             child: Text(
//                                               "${chapter.chapter}",
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 16,
//                                                 color: Color(0xFF9C4D00),
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

