import 'package:edumate/pages/newhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/bottom_nav.dart';

class ProfilePage extends StatefulWidget {


  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool value = false;
  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00000000),
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
        child: SafeArea(
            child: Scaffold(
              extendBody: true,
              bottomNavigationBar: BottomNav(context: context),
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute (
                      builder: (BuildContext context) => NewHomePage(),
                    ),);
                    //Navigator.popUntil(context, ModalRoute.withName('/home'));
                    //Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
                  backgroundColor: Color(0x00ffffff),
                  centerTitle: true,
                title: Text('Profile'),
              ),
            body: Column(
              children: [
               Stack(
                 children: <Widget>[
                   // backWidget,
                   Container(
                     height: 250,
                     color: const Color(0x00000000),
                   ),
                   Positioned(
                     top: (MediaQuery.of(context).size.height * 0.09),
                     left: (MediaQuery.of(context).size.width * 0.1),
                     child: Container(
                       decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.all(
                           Radius.circular(20)
                         ),
                       ),
                       width: MediaQuery.of(context).size.width * 0.79,
                       height: 170,
                       padding: const EdgeInsets.only(bottom: 20, left: 30,),
                       child: FittedBox(
                         alignment: Alignment.centerLeft,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.end,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(height: 10,),
                             InkWell(
                               onTap: (){},
                               child: Icon(Icons.more_vert, color: Color(0xff2B2E44),),
                             ),
                             SizedBox(height: 15),
                             Text(
                               "Utkarsh\nSingh",
                               style: TextStyle(
                                 color: Color(0xff2B2E44),
                                 fontSize: 28,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             SizedBox(
                               height: 9,
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Text(
                                   "email@gmail.com",
                                   style: TextStyle(
                                     color: Color(0xff2B2E44),
                                     fontSize: 18,
                                     fontWeight: FontWeight.w400,
                                   ),

                                 ),
                                 // SizedBox(width: 50,),
                                 Image.asset("assets/icons/write_icon.png"),




                               ],
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                   Positioned(
                     top: MediaQuery.of(context).size.height*0.01,
                     left: (MediaQuery.of(context).size.width * 0.5 )-57,
                     child: CircleAvatar(
                       backgroundColor: Colors.transparent,
                       radius: 57,
                       backgroundImage:
                       const AssetImage('assets/images/profile.jpg'),
                     ),
                   ),
                 ],
               ),
                Container(
                  padding: const EdgeInsets.only(left: 45.0, top: 12, right: 45.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("General", style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),),
                        SizedBox(height: 12,),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/icons/profile_general_icon.svg"),
                                  SizedBox(width: 11,),
                                  Text("General", style: TextStyle(fontSize: 21, color: Colors.white),),
                                ],
                              ),
                              //SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                              SvgPicture.asset("assets/icons/angle-double-right.svg"),

                            ],
                          ),
                        SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/profile_notif_icon.svg"),
                                SizedBox(width: 11,),
                                Text("Notifications", style: TextStyle(fontSize: 21, color: Colors.white),),
                              ],
                            ),
                            //SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                            SvgPicture.asset("assets/icons/angle-double-right.svg"),

                          ],
                        ),
                        SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/contactus_icon.svg"),
                                SizedBox(width: 11,),
                                Text("Contact us", style: TextStyle(fontSize: 21, color: Colors.white),),
                              ],
                            ),
                            //SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                            SvgPicture.asset("assets/icons/angle-double-right.svg"),

                          ],
                        ),
                        SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/profile_settings_icon.svg"),
                                SizedBox(width: 11,),
                                Text("Settings", style: TextStyle(fontSize: 21, color: Colors.white),),
                              ],
                            ),
                            //SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                            SvgPicture.asset("assets/icons/angle-double-right.svg"),

                          ],
                        ),
                        SizedBox(height: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icons/profile_logout_icon.svg"),
                                SizedBox(width: 11,),
                                Text("Logout", style: TextStyle(fontSize: 21, color: Colors.white),),
                              ],
                            ),
                            //SizedBox(width: MediaQuery.of(context).size.width*0.3,),

                          ],
                        ),
                      ],
                    ),

                ),


              ],
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

     )
    );
  }
}
