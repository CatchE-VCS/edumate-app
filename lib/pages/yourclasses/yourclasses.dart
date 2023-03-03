import 'package:edumate/pages/yourclasses/emoji.dart';
import 'package:edumate/pages/yourclasses/featureCourse.dart';
import 'package:edumate/pages/yourclasses/searchInput.dart';
import 'package:edumate/themes/color.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    ListView(
      children: [
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
        bottomNavigationBar: _builtBottomNavigationBar(),
      ),
    );
  }

  BottomNavigationBar _builtBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kBackground,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.only(bottom: 4),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: kAccent, width: 2))),
              child: const Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            label: 'home'),
        const BottomNavigationBarItem(
            label: 'calendar', icon: Icon(Icons.chat_bubble_outline)),
        const BottomNavigationBarItem(
            label: 'bookmark', icon: Icon(Icons.bookmark_border_outlined)),
        const BottomNavigationBarItem(
            label: 'user', icon: Icon(Icons.supervised_user_circle_rounded)),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItenTap,
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
