import 'package:edumate/redeem.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';

class Coins extends StatelessWidget {
  const Coins({Key? key}) : super(key: key);

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
          title: Row(children: [
            Text('User'),
            SizedBox(
              width: 150,
            ),
            Text("110"),
            Image.asset('assets/images/coin.png')
          ]),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 25, top: 48),
              width: 311,
              height: 111,
              decoration: BoxDecoration(
                  color: Color(0x749C5ECC),
                  borderRadius: BorderRadius.all(Radius.circular(23))),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset('assets/images/tshirt.png'),
                  SizedBox(
                    width: 10,
                  ),
                  Column(children: [
                    SizedBox(
                      height: 24,
                    ),
                    Text("Programming Tshirt"),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("1500"),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/coin.png'),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tshirt()));
                          },
                          child: Text("Redeem Now"),
                        )
                      ],
                    )
                  ])
                ],
              ),
            ),
            SizedBox(
              height: 29,
            ),
            Container(
              margin: EdgeInsets.only(left: 25, top: 48),
              width: 311,
              height: 111,
              decoration: BoxDecoration(
                  color: Color(0x749C5ECC),
                  borderRadius: BorderRadius.all(Radius.circular(23))),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset('assets/images/bag.png'),
                  SizedBox(
                    width: 10,
                  ),
                  Column(children: [
                    SizedBox(
                      height: 24,
                    ),
                    Text("EduMate Bag"),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("1500"),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/coin.png'),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text("Redeem Now"),
                        )
                      ],
                    )
                  ])
                ],
              ),
            ),
            SizedBox(
              height: 29,
            ),
            Container(
              margin: EdgeInsets.only(left: 25, top: 48),
              width: 311,
              height: 111,
              decoration: BoxDecoration(
                  color: Color(0x749C5ECC),
                  borderRadius: BorderRadius.all(Radius.circular(23))),
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Image.asset('assets/images/coolpad.png'),
                  SizedBox(
                    width: 10,
                  ),
                  Column(children: [
                    SizedBox(
                      height: 24,
                    ),
                    Text("Laptop Cooler"),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Text("1500"),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset('assets/images/coin.png'),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text("Redeem Now"),
                        )
                      ],
                    )
                  ])
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
