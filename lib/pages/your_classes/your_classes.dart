import 'package:edumate/pages/newhome.dart';
import 'package:edumate/pages/your_classes/emoji.dart';
import 'package:edumate/pages/your_classes/feature_course.dart';
import 'package:edumate/pages/your_classes/searchInput.dart';
import 'package:edumate/themes/color.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    ListView(
      children: [
        const Con(),
        const EmojiText(),
        const SearchInput(),
        FeatureCourse1(),
        FeatureCourse2(),
        FeatureCourse()
      ],
    ),
    Text('Form'),
  ];

  void _onItenTap(int index) {
    setState(() {
      print(_selectedIndex);
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNav(context: context),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,
      title: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            'Hello User',
            style: TextStyle(fontSize: 16, color: kFontLight),
          )),
      actions: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, right: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: kFontLight.withOpacity(0.3), width: 2),
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.circle_notifications_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            Positioned(
                top: 15,
                right: 30,
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: const BoxDecoration(
                      color: kAccent, shape: BoxShape.circle),
                ))
          ],
        )
      ],
    );
  }
}

class Con extends StatelessWidget {
  const Con({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 329,
      height: 49,
      margin: EdgeInsets.only(left: 13, right: 10),
      decoration: BoxDecoration(
          color: Color(0xFF5D5392),
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => NewHomePage())),
            child: Container(
              width: 161,
              height: 41,
              margin: EdgeInsets.only(left: 7),
              child: Center(child: Text("All Courses")),
            ),
          ),
          Container(
            width: 161,
            height: 41,
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
                color: Color(0xFF897BD2),
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Center(child: Text("Your Classes")),
          ),
        ],
      ),
    );
  }
}
