import 'package:edumate/pages/yourclasses/yourclasses.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewHomePage extends StatelessWidget {
  const NewHomePage({Key? key}) : super(key: key);

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
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomNav(context: context),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios)),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Courses'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 334,
                  height: 49,
                  margin: EdgeInsets.only(left: 13),
                  decoration: BoxDecoration(
                      color: Color(0xFF5D5392),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 161,
                        height: 41,
                        margin: EdgeInsets.only(left: 7),
                        decoration: BoxDecoration(
                            color: Color(0xFF897BD2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: Center(child: Text("All Courses")),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: 42),
                            child: Text('Your Classes')),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 27,
                ),
                Container(
                  margin: EdgeInsets.only(right: 75),
                  child: Text(
                    "What do you want to\n learn today ?",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 28),
                      width: 82,
                      height: 29,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(70)),
                          color: Color(0xFF897BD2)),
                      child: Center(child: Text("Design")),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 104,
                      height: 29,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(70)),
                          color: Color(0xFF5D5392)),
                      child: Center(child: Text("All Courses")),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 64,
                      height: 29,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(70)),
                          color: Color(0xFF5D5392)),
                      child: Center(child: Text("UI/UX")),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 125,
                  height: 29,
                  margin: EdgeInsets.only(right: 175),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(70)),
                      color: Color(0xFF5D5392)),
                  child: Center(
                      child: Text(
                    "Development",
                    style: TextStyle(fontSize: 15),
                  )),
                ),
                SizedBox(
                  height: 28,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Container(
                    margin: EdgeInsets.only(left: 29),
                    child: Text(
                      "Best online Courses about 'Design' ",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Text(
                    "50 Results",
                    style: TextStyle(fontSize: 13),
                  ),
                ]),
                SizedBox(
                  height: 14,
                ),
                GestureDetector(
                  onTap: () async {
                    const url =
                        'https://www.udemy.com/course/photoshop-masking/';
                    final uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    width: 334,
                    height: 163,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFDF77CF),
                              Color(0xE6B24DA2),
                              Color(0xCC9A478D),
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 16,
                            height: 14,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(70)),
                                color: Colors.white),
                            width: 86,
                            height: 25,
                            child: Center(
                                child: Text(
                              "Best Selling",
                              style: TextStyle(
                                  color: Color(0xFFDF77CF), fontSize: 13),
                            )),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Text(
                              "Graphic Design :\n Core Principles for\n Visual Design",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 23,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 24),
                                child: Image.asset('assets/images/second.png'),
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text(
                                "4.9",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 15),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Image.asset('assets/images/first.png')
                    ]),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  width: 334,
                  height: 163,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFA798F8),
                            Color(0xA6B0A4ED),
                            Color(0xA69182DC),
                            Color(0x669182DC)
                          ]),
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  child: Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 16,
                          height: 14,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(70)),
                              color: Colors.white),
                          width: 86,
                          height: 25,
                          child: Center(
                              child: Text(
                            "Best Selling",
                            style: TextStyle(
                                color: Color(0xFF897BD2), fontSize: 13),
                          )),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Graphic Design :\n Core Principles for\n Visual Design",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 23,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 24),
                              child: Image.asset('assets/images/second.png'),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "4.8",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 15),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: 17,
                    ),
                    Image.asset('assets/images/third.png')
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
