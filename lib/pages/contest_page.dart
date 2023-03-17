import 'dart:convert';

import 'package:edumate/helpers/contest_model.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_svg/svgart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ContestPage extends StatefulWidget {
  const ContestPage({Key? key}) : super(key: key);

  @override
  State<ContestPage> createState() => _ContestPageState();
}

late List<NewsModel> _userModel = [];

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

  bool? value = false;
  Widget _partContainer(
      {required String name,
      required String date,
      required String starttime,
      required String endtime}) {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          _open
              ? Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 15, bottom: 15, top: 15),
                          child: _circularContainer(
                              name: name,
                              date: date,
                              starttime: starttime,
                              endtime: endtime),
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
  // void _getData() async {
  //   _userModel = await getData();
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _getData();
  // }

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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("Competitive Contest"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
          bottomNavigationBar: BottomNav(
            context: context,
          ),
          extendBody: true,
          body: FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _circularContainer(
                          name: snapshot.data![index].name.toString(),
                          date: snapshot.data![index].url,
                          starttime: snapshot.data![index].duration.toString(),
                          endtime: snapshot.data![index].site.toString());
                    });
              })),
    );
  }

  Widget _circularContainer(
      {required String name,
      required String date,
      required String starttime,
      required String endtime}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(children: [
        Container(
          height: 120,
          width: 350,
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
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                "$name",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () async {
                String url = date;
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(
                "$date",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "$endtime",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )
          ],
        )
        // Positioned(
        //     top: 10,
        //     left: 13,
        //     child: SizedBox(
        //         width: 122,
        //         child: Text(
        //           "$name",
        //           style:
        //               TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //         ))),
        // Positioned(
        //     top: 47,
        //     left: 13,
        //     child: SizedBox(
        //         width: 122,
        //         child: Text(
        //           "$date",
        //           style: TextStyle(
        //               color: Colors.white,
        //               fontWeight: FontWeight.bold,
        //               fontSize: 12),
        //         ))),
        // Positioned(
        //     top: 15,
        //     left: 200,
        //     child: SizedBox(
        //         width: 122,
        //         child: Text(
        //           "$starttime - $endtime",
        //           style:
        //               TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //         ))),
      ]),
    );
  }
}
