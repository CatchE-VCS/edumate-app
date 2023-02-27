import 'package:flutter/material.dart';

class SkillScreen extends StatelessWidget {
  const SkillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: const [
          ColoredBox(
            color: Color(0xff30547c),
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Text("What skills do you currently have ?"),
            ),
          ),

        ],
      ),
    );
  }
}
