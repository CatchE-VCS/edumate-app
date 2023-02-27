import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff705cdc),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff705cdc),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            iconSize: 40,
            icon: Icon(Icons.cancel),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
      ),

      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 8,),
              Row(
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
            Icon(Icons.home_filled, color: Colors.white,),
            SizedBox(width: 35,),
            Text("Log out", style: TextStyle(fontSize: 15, color: Colors.white),)
          ],
        ),
      ),
    );
  }
}
