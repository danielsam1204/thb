import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thb/common/app_color.dart';
import 'package:thb/screens/user/sigin.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  final List<Map<String, String>> pages = [
    {
      "title": "bible_learnings".tr,
      "desc": "lessons_from_the_scriptures_for_daily_living".tr,
      "image": "assets/image/landing_page/bible.png",
    },
    {
      "title": "prayers_and_devotions".tr,
      "desc": "daily_prayers_and_spiritual_guidance".tr,
      "image": "assets/image/landing_page/prayer.png",
    },
    {
      "title": "church_and_fellowship".tr,
      "desc": "strengthen_your_faith_with_fellowship".tr,
      "image": "assets/image/landing_page/church.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBrown, // Dark Brown background
      body: SafeArea(
        child: Stack(
          children: [
           PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final page = pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 40,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          page["title"]!,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.offWhite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        Image.asset(page["image"]!, height: 220),
                        const SizedBox(height: 25),

                        // const SizedBox(height: 12),
                        Text(
                          page["desc"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.offWhite,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),

            Column(
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 30,
                    left: 24,
                    right: 24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button
                      GestureDetector(
                        onTap: () {
                          if (_currentPage > 0) {
                            _controller.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: _currentPage > 0
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(1000),
                                  ),
                                  border: Border.all(
                                    color: AppColors.offWhite,
                                    width: 2,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    color: AppColors.offWhite,
                                  ),
                                ),
                              )
                            : const SizedBox(
                                width: 24,
                              ), // Placeholder for alignment
                      ),

                      // Dots Indicator
                      Row(
                        children: List.generate(pages.length, (index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: _currentPage == index ? 12 : 8,
                            height: _currentPage == index ? 12 : 8,
                            decoration: BoxDecoration(
                              color: _currentPage == index
                                  ? AppColors.offWhite
                                  : AppColors.orangeLight,
                              shape: BoxShape.circle,
                            ),
                          );
                        }),
                      ),

                      // Next / Done Button
                      GestureDetector(
                        onTap: () async {
                          if (_currentPage == pages.length - 1) {
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>BiblePage()));
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool("landing", true);
                          } else {
                            _controller.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(1000),
                            ),
                            border: Border.all(
                              color: AppColors.offWhite,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              _currentPage == pages.length - 1
                                  ? Icons.check
                                  : Icons.arrow_forward_ios_rounded,
                              color: AppColors.offWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
