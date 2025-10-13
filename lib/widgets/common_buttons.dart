import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final String? text;
  final Widget? widget;
  final String? ImageIconSize;
  final bool? fill;
  final VoidCallback? onTap;

  const CustomeButton({
    super.key,
    this.text,
    this.widget,
    this.ImageIconSize,
    this.fill,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(
              color: fill == false ? Colors.white : Colors.black,
            ),
            color: fill == false ? Colors.transparent : Colors.white,
          ),

          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget != null) ...[widget!],
                if (ImageIconSize != null) ...[
                  Image.asset(ImageIconSize!, width: 25),
                  SizedBox(width: 10, height: 30),
                ],
                if (text != null) ...[
                  Text(
                    text!,
                    style: TextStyle(
                      color: fill == false ? Colors.white : Colors.black,
                    ),
                  ),
                ],
                SizedBox( height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TitleSubTitle extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final Widget? subWidget;

  const TitleSubTitle({super.key, this.title, this.subTitle, this.subWidget});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              "${title}",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ],
          if (subTitle != null) ...[
            Text("${subTitle}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 5,width: 5,)
          ],
          if (subWidget != null) ...[subWidget!,SizedBox(height: 20,width: 20,)],
        ],
      ),
    );
  }
}

class TextDivider extends StatelessWidget {
  final String text;
  final String? textontap;
  final VoidCallback? onTap;

  const TextDivider({
    super.key,
    required this.text,
    this.onTap,
    this.textontap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 30),
      child: Row(
        children: [
          const Expanded(
            child: Divider(color: Colors.white, thickness: 1, endIndent: 10),
          ),
          const SizedBox(height: 5, width: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          if (textontap != null) ...[
            const SizedBox(height: 5, width: 5),
            GestureDetector(
              onTap: onTap,
              child: Text(
                textontap!,
                style: const TextStyle(
                  color: Colors.yellow,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
          const SizedBox(height: 5, width: 5),
          const Expanded(
            child: Divider(color: Colors.white, thickness: 1, endIndent: 10),
          ),
        ],
      ),
    );
  }
}

InputDecoration textInputDecoration(String? hintText) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(color: Colors.white70, fontSize: 16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white70, width: 1.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );
}
