import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
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
      backgroundColor: Color(0xff2B2E44),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff2B2E44),
      ),
      // PreferredSize(
      //   preferredSize: const Size.fromHeight(240),
      //   child: Container(
      //     color: Colors.transparent,
      //     child: const Text("Profile"),
      //   ),
      // ),
      body: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          child: Stack(
            children: <Widget>[
              // backWidget,

              Positioned(
                top: (MediaQuery.of(context).size.height * 0.1),
                left: (MediaQuery.of(context).size.width * 0.1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      // topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      // bottomRight: Radius.circular(20),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  padding: const EdgeInsets.only(bottom: 20, left: 30,),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Icon(Icons.more_vert, color: Color(0xff2B2E44),),
                      ),
                      SizedBox(height: 40,),
                      Text(
                        "Utkarsh\nSingh",
                        style: TextStyle(
                          color: Color(0xff2B2E44),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "emial@gmail.com",
                        style: TextStyle(
                          color: Color(0xff2B2E44),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: (MediaQuery.of(context).size.width * 0.5 )-72,
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 72,
                  backgroundImage:
                      const AssetImage('assets/images/profile.jpg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
