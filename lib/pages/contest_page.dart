import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/bottom_nav.dart';

class ContestPage extends StatefulWidget {


  const ContestPage({super.key});

  @override
  State<ContestPage> createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {

  bool value = false;
  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0x00000000),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1F0E14),
                    Color(0xBF37194C),
                    Color(0xB34E2178),
                    Color(0xD934134F),
                    Color(0xFF1F0E24),
                  ])),
          child: SafeArea(
            child: Scaffold(
              extendBody: true,
              bottomNavigationBar: BottomNav(context: context),
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                backgroundColor: Color(0x00fffff),
                centerTitle: true,
                title: Text('Competitive Progamming'),
              ),
              body: Column(
                children: [



                ],
              ),
            ),
          ),
          // appBar: AppBar(
          //   elevation: 0,
          //   backgroundColor: Color(0xff2B2E44),
          // ),
          // PreferredSize(
          //   preferredSize: const Size.fromHeight(240),
          //   child: Container(
          //     color: Colors.transparent,
          //     child: const Text("Profile"),
          //   ),
          // ),

        )
    );
  }
}
