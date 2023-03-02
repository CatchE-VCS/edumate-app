import 'package:edumate/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

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
          body: Column(
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
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                      child: Center(child: Text("All Courses")),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 42),
                        child: Text('Your Classes'))
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
                    child: Center(child: Text("Design")),
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
              ])
            ],
          ),
        ),
      ),
    );
  }
}
