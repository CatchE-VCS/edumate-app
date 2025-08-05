import 'package:flutter/material.dart';

class EmojiText extends StatelessWidget {
  const EmojiText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 25),
      child: RichText(
        text: const TextSpan(children: [
          TextSpan(
              text: 'Dreams Dont Work\nUnless You Do ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white)),
          TextSpan(text: '✨', style: TextStyle(fontSize: 26))
        ]),
      ),
    );
  }
}
