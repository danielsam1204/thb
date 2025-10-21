import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thb/widgets/custom_app_bar.dart';

class PosterScreen extends StatelessWidget {
  const PosterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: "posters".tr, onTap: ()=> Navigator.pop(context),),
      body: GridView.builder(
        padding: EdgeInsets.all(14),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("assets/image/home/daily_promise.png"),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
