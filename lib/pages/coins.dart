import 'package:flutter/material.dart';

class Coins extends StatelessWidget {
  const Coins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 15,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(41, 20, 0, 30),
            width: 270,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: Color(0xff1f0e34),
                )),
            child: Container(
              margin: EdgeInsets.fromLTRB(50, 50, 50, 80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  border: Border.all(
                    color: Color(0xff1f0e34),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Text(
                    "STREAK",
                    style: TextStyle(color: Color(0xff1f0e34), fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '45',
                    style: TextStyle(color: Color(0xff1f0e34), fontSize: 18),
                  ),
                  Text(
                    'days',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(41, 0, 0, 0),
            width: 270,
            height: 300,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: Color(0xff1f0e34),
                )),
            child: Container(
              margin: EdgeInsets.fromLTRB(50, 50, 50, 80),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(1000)),
                  border: Border.all(
                    color: Color(0xff1f0e34),
                  )),
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.network(
                        'https://media.geeksforgeeks.org/img-practice/geekBits-1628159745.png'),
                    Text(
                      " 104",
                      style: TextStyle(color: Color(0xff1f0e34), fontSize: 20),
                    ),
                  ]),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: Color(0xff1f0e34),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: Center(
              child: Text(
                "Redeem Reward",
              ),
            ),
          )
        ],
      ),
    );
  }
}
