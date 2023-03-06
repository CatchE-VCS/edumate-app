import 'dart:convert';

import 'package:edumate/helpers/contest_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;

import '../widgets/bottom_nav.dart';

class ContestPage extends StatefulWidget {
  const ContestPage({super.key});

  @override
  State<ContestPage> createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  Future<List<NewsModel>> getData() async {
    http.Response response =
        await http.get(Uri.parse('https://kontests.net/api/v1/all'));
    if (response.statusCode == 200) {
      String data = response.body;
      // print(response.body);
      print(jsonDecode(data));
      return newsModelFromJson(data);
    } else {
      print(response.statusCode);
      print(response.body);
      return [];
    }
  }

  bool _open = true;
  int currentPageIndex = 0;
  static const List<Tab> myTabs = <Tab>[
    Tab(text: 'All'),
    Tab(text: 'Codeforces'),
    Tab(text: 'Codechef'),
    Tab(text: 'Leetcode'),
  ];

  bool value = false;
  Widget _partContainer() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _open = !_open;
              });
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/contest_icon.svg",
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Within 24 hours",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
              ],
            ),
          ),
          _open
              ? Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 15, bottom: 15, top: 15),
                          child: _circularContainer(
                              name: "Codeforces Round#855 (Div. 3)",
                              date: "4th Feb 2023",
                              starttime: "20:55",
                              endtime: "22:20"),
                        );
                      }),
                )
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }

  Widget _circularContainer(
      {required String name,
      required String date,
      required String starttime,
      required String endtime}) {
    return Stack(children: [
      Container(
        height: 73,
        width: 294,
        decoration: BoxDecoration(
          //shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffA798F8),
                Color(0xBFB0A4ED),
                Color(0xB39182DC),
                Color(0xD9D1A4ED),
              ]),
          borderRadius: BorderRadius.circular(23),
          color: Colors.white,
          //border: Border.all(color: borderColor, width: borderWidth),
        ),
      ),
      Positioned(
          top: 10,
          left: 13,
          child: SizedBox(
              width: 122,
              child: Text(
                "$name",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
      Positioned(
          top: 47,
          left: 13,
          child: SizedBox(
              width: 122,
              child: Text(
                "$date",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ))),
      Positioned(
          top: 15,
          left: 200,
          child: SizedBox(
              width: 122,
              child: Text(
                "$starttime - $endtime",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00000000),
      body: Container(
        child: SafeArea(
          child: Scaffold(
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
              child: DefaultTabController(
                length: myTabs.length,
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
                    bottom: TabBar(
                      tabs: myTabs,
                    ),
                  ),
                  body: TabBarView(
                    children: myTabs.map((Tab tab) {
                      final String label = tab.text!.toLowerCase();
                      return _partContainer();
                    }).toList(),
                  ),
                ),
              ),
            ),
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
    );
  }
}
