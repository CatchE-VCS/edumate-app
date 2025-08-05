import 'package:edumate/pages/profile_page.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff705cdc),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xff705cdc),
        leading: Builder(

          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                iconSize: 40,
                icon: Icon(Icons.cancel),
                onPressed: () => Navigator.of(context).pop(),
              ),
            );
          }
        ),
      ),

      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 8,),
              InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage())),
                child: Row(
                  children: [
                    CircleAvatar(
                      child: ColoredBox(color: Colors.white,),
                    ),
                    SizedBox(width: 15,),
                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Jonathan Larson", style: TextStyle(fontSize: 18, color: Colors.white),),
                        SizedBox(height: 5,),
                        Text("UI/UX Designer", style: TextStyle(fontSize: 12, color: Color(0xffDEDEDE)),)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: 60,),
              Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.home_filled, color: Colors.white,),
                        SizedBox(width: 35,),
                        Text("Home", style: TextStyle(fontSize: 15, color: Colors.white),)
                      ],
                    ),
                  ),
                  SizedBox(height: 35,),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.home_filled, color: Colors.white,),
                        SizedBox(width: 35,),
                        Text("Courses", style: TextStyle(fontSize: 15, color: Colors.white),)
                      ],
                    ),
                  ),
                  SizedBox(height: 35,),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.home_filled, color: Colors.white,),
                        SizedBox(width: 35,),
                        Text("Schedule", style: TextStyle(fontSize: 15, color: Colors.white),)
                      ],
                    ),
                  ),
                  SizedBox(height: 35,),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.home_filled, color: Colors.white,),
                        SizedBox(width: 35,),
                        Text("Contact us", style: TextStyle(fontSize: 15, color: Colors.white),)
                      ],
                    ),
                  ),
                  SizedBox(height: 35,),
                  Container(
                    child: Row(
                      children: [
                        SizedBox(height: 37,child: Image.asset("assets/icons/settings_icon.png")),
                        SizedBox(width: 35,),
                        Text("Settings", style: TextStyle(fontSize: 15, color: Colors.white),)
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
          SizedBox(height: 37,child: Image.asset("assets/icons/logout_icon.png")),
            SizedBox(width: 35,),
            Text("Log out", style: TextStyle(fontSize: 15, color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
