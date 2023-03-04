import 'package:edumate/nn.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:edumate/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NewHomePage extends StatefulWidget {
  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
        child: SafeArea(
            child: Scaffold(
          drawer: Drawer(
            child: DrawerScreen(),
          ),
          extendBody: true,
          bottomNavigationBar: BottomNav(context: context),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Image.asset("assets/icons/drawer_button.png"));
            }),
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text('Courses'),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  indicatorWeight: 2,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  controller: tabController,
                  tabs: [
                    Tab(
                      text: 'Tab 1',
                    ),
                    Tab(
                      text: 'Tab 1',
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    // Tab1(),
                    NN(),
                    NN()
                    // Tab2(),
                  ],
                ),
              ),
              // Container(
              //   width: 334,
              //   height: 49,
              //   margin: EdgeInsets.only(left: 13),
              //   decoration: BoxDecoration(
              //       color: Color(0xFF5D5392),
              //       borderRadius: BorderRadius.all(Radius.circular(25))),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Container(
              //         width: 161,
              //         height: 41,
              //         margin: EdgeInsets.only(left: 7),
              //         decoration: BoxDecoration(
              //             color: Color(0xFF897BD2),
              //             borderRadius: BorderRadius.all(Radius.circular(25))),
              //         child: Center(child: Text("All Courses")),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => HomePage()));
              //         },
              //         child: Container(
              //             margin: EdgeInsets.only(right: 42),
              //             child: Text('Your Classes')),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 27,
              // ),
              // Container(
              //   margin: EdgeInsets.only(right: 75),
              //   child: Text(
              //     "What do you want to\n learn today ?",
              //     style: TextStyle(fontSize: 24),
              //   ),
              // ),
              // SizedBox(
              //   height: 16,
              // ),
              // Row(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.only(left: 28),
              //       width: 82,
              //       height: 29,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.all(Radius.circular(70)),
              //           color: Color(0xFF897BD2)),
              //       child: Center(child: Text("Design")),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Container(
              //       width: 104,
              //       height: 29,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.all(Radius.circular(70)),
              //           color: Color(0xFF5D5392)),
              //       child: Center(child: Text("All Courses")),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Container(
              //       width: 64,
              //       height: 29,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.all(Radius.circular(70)),
              //           color: Color(0xFF5D5392)),
              //       child: Center(child: Text("UI/UX")),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Container(
              //   width: 125,
              //   height: 29,
              //   margin: EdgeInsets.only(right: 175),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.all(Radius.circular(70)),
              //       color: Color(0xFF5D5392)),
              //   child: Center(
              //       child: Text(
              //     "Development",
              //     style: TextStyle(fontSize: 15),
              //   )),
              // ),
              // SizedBox(
              //   height: 28,
              // ),
              // Text(
              //   "Designing Courses",
              //   style: TextStyle(fontSize: 22, color: Colors.white),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              //   Container(
              //     margin: EdgeInsets.only(left: 29),
              //     child: Text(
              //       "Best online Courses about 'Design' ",
              //       style: TextStyle(fontSize: 13),
              //     ),
              //   ),
              //   SizedBox(
              //     width: 50,
              //   ),
              //   Text(
              //     "50 Results",
              //     style: TextStyle(fontSize: 13),
              //   ),
              // ]),
              // SizedBox(
              //   height: 15,
              // ),
              // Container1(
              //   urle: 'https://www.udemy.com/course/photoshop-masking/',
              //   text: "Graphic Design :\n Core Principles for\n Visual Design",
              //   img: 'assets/images/first.png',
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              // Container2(
              //   img: 'assets/images/third.png',
              //   text: 'Create a Bold,\nColorful Album,\ngitCover',
              //   urle:
              //       'https://www.udemy.com/course/adobe-photoshop-album-cover-design/',
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              // Container1(
              //   urle:
              //       'https://www.udemy.com/course/premiere-pro-lumetri-color-correct-like-a-pro/',
              //   text: "Premier Pro Lumetri\nColor Correct\nlike a Pro",
              //   img: 'assets/images/first.png',
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              // Container2(
              //   img: 'assets/images/third.png',
              //   text: 'Adobe Premiere Pro,\nMasterclass:Video',
              //   urle:
              //       'https://www.udemy.com/course/adobe-premiere-pro-video-editing/',
              // ),
              // SizedBox(
              //   height: 24,
              // ),
              // Container1(
              //   urle: 'https://www.udemy.com/course/incrediblevideocreator/',
              //   text: "Filmmaker:\nVideo Creator",
              //   img: 'assets/images/first.png',
              // ),
            ]),
          ),
        )));
  }
}

class Container1 extends StatelessWidget {
  String text;
  String img;
  String urle;
  Container1({required this.text, required this.img, required this.urle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String url = urle;
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
                    borderRadius: BorderRadius.all(Radius.circular(70)),
                    color: Colors.white),
                width: 86,
                height: 25,
                child: Center(
                    child: Text(
                  "Best Selling",
                  style: TextStyle(color: Color(0xFFDF77CF), fontSize: 13),
                )),
              ),
              SizedBox(
                height: 9,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            width: 17,
          ),
          Image.asset(img)
        ]),
      ),
    );
  }
}

class Container2 extends StatelessWidget {
  String text;
  String img;
  String urle;
  Container2({required this.text, required this.img, required this.urle});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        String url = urle;
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
                    borderRadius: BorderRadius.all(Radius.circular(70)),
                    color: Colors.white),
                width: 86,
                height: 25,
                child: Center(
                    child: Text(
                  "Best Selling",
                  style: TextStyle(color: Color(0xFF897BD2), fontSize: 13),
                )),
              ),
              SizedBox(
                height: 9,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
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
    );
  }
}
