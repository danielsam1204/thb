import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/screens/home/widgets/posters_widget.dart';
import 'package:thb/widgets/custom_app_bar.dart';

class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: "posters".tr,
        onTap: () => Navigator.pop(context),
      ),
      body: PostersWidget(fromHome: false),
    );
  }
}

Widget posterGridView() {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(14),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return posterCard();
        },
      ),
    ),
  );
}

Widget posterListView() {
  return ListView.builder(
    padding: const EdgeInsets.fromLTRB(14, 0, 6, 0),
    itemCount: 5,
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemBuilder: (context, index) {
      return posterCard();
    },
  );
}

Widget posterCard() {
  final width = MediaQuery.of(Get.context!).size.width;
  return Container(
    margin: EdgeInsets.only(right: 12),
    width: width * 0.43,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: AssetImage("assets/image/home/daily_promise.png"),
        fit: BoxFit.cover,
      ),
    ),
  );
}
