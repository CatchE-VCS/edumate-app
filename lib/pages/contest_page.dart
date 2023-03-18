import 'dart:convert';

import 'package:edumate/helpers/codeforces_contest_model.dart';
import 'package:edumate/helpers/contest_model.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
  late Future<List<NewsModel>> data_all;
  late Future<List<CodeforcesModel>> data_codechef;
  late Future<List<CodeforcesModel>> data_codeforces;
  late Future<List<CodeforcesModel>> data_leetcode;

  Future<List<CodeforcesModel>> getDataCodeforces({required String tab}) async {
    http.Response response =
    await http.get(Uri.parse('https://kontests.net/api/v1/$tab'));
    if (response.statusCode == 200) {
      String data = response.body;
      // print(response.body);
      print(jsonDecode(data));
      return codeforcesModelFromJson(data);
    } else {
      print(response.statusCode);
      print(response.body);
      return [];
    }
  }

  Future<List<NewsModel>> getData({required String tab}) async {
    http.Response response =
        await http.get(Uri.parse('https://kontests.net/api/v1/$tab'));
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
    Tab(text: 'All',  ),
    Tab(text: 'Codeforces'),
    Tab(text: 'Codechef'),
    Tab(text: 'Leetcode'),
  ];

  // static  Map<String, Future<List<NewsModel>>> _map1 = {
  //   "All" : data,
  //   "Hackerrank" : "hacker_rank",
  //   "Codeforces" : "code_forces",
  //   "Leetcode" : "leet_code",
  //   "Codechef" : "code_chef"
  // };

  static const Map<String, String> _map = {
    "All" : "all",
    "Hackerrank" : "hacker_rank",
    "Codeforces" : "code_forces",
    "Leetcode" : "leet_code",
    "Codechef" : "code_chef"
  };

  bool? value = false;
  Widget _partContainer(String label) {

    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        children: [
          SizedBox(height: 15,),
          InkWell(
            onTap: () {
              setState(() {
                _open = !_open;
              });
            },
            child: Row(
              children: [
                SvgPicture.asset("assets/icons/contest_icon.svg",),
                SizedBox(width: 10,),
                Text("Within 24 hours", style: TextStyle(fontSize: 20, color: Colors.white),)
              ],
            ),
          ),
          _open
              ? Container(
                  height: 500,
                  child: (label == "All") ?
                  FutureBuilder(
                      future: data_all,
                      builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 30.0, right: 15, bottom: 15, top: 15),
                                  child: _circularContainer(
                                      name: snapshot.data![index].name.toString(),
                                      date: snapshot.data![index].url,
                                      starttime: snapshot.data![index].duration.toString(),
                                      endtime: snapshot.data![index].site.toString()),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('error fetching data : ${snapshot.error}'));
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      }) :
                  (label == "Codeforces" ?
                  FutureBuilder(
                      future: data_codeforces,
                      builder: (context, AsyncSnapshot<List<CodeforcesModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 30.0, right: 15, bottom: 15, top: 15),
                                  child: _circularContainer(
                                      name: snapshot.data![index].name.toString(),
                                      date: snapshot.data![index].url,
                                      starttime: snapshot.data![index].duration.toString(),
                                      endtime: snapshot.data![index].duration.toString()),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('error fetching data : ${snapshot.error}'));
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      }) : (label == "Codechef" ?
                  FutureBuilder(
                      future: data_codechef,
                      builder: (context, AsyncSnapshot<List<CodeforcesModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 30.0, right: 15, bottom: 15, top: 15),
                                  child: _circularContainer(
                                      name: snapshot.data![index].name.toString(),
                                      date: snapshot.data![index].url,
                                      starttime: snapshot.data![index].duration.toString(),
                                      endtime: snapshot.data![index].duration.toString()),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('error fetching data : ${snapshot.error}'));
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      }) :
                  FutureBuilder(
                      future: data_leetcode,
                      builder: (context, AsyncSnapshot<List<CodeforcesModel>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 30.0, right: 15, bottom: 15, top: 15),
                                  child: _circularContainer(
                                      name: snapshot.data![index].name.toString(),
                                      date: snapshot.data![index].url,
                                      starttime: snapshot.data![index].duration.toString(),
                                      endtime: snapshot.data![index].duration.toString()),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('error fetching data : ${snapshot.error}'));
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      }))),

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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data_all = getData(tab: "all");
    data_codechef = getDataCodeforces(tab : "code_chef");
    data_codeforces = getDataCodeforces(tab: "codeforces");
    data_leetcode = getDataCodeforces(tab: "leet_code");
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
              bottom:  TabBar(
                tabs: myTabs,
              ),
            ),
            body: TabBarView(
              children: myTabs.map((Tab tab) {
                final String label = tab.text!;
                return _partContainer(label);
              }).toList(),
            ),
          ),
        ),
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
