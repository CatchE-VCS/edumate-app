import 'package:edumate/pages/yourclasses/courseModule.dart';
import 'package:edumate/pages/yourclasses/module.dart';
import 'package:flutter/material.dart';

class CourseProgress extends StatelessWidget {
  final moduleList = Module.generateModule();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'The Progress',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Image.network(
                      'https://cdn3.iconfinder.com/data/icons/faticons/32/grid-2-01-512.png',
                      width: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Image.network(
                      'https://www.freeiconspng.com/thumbs/list-icon/checklist-icon-checklist-icon-png-list-icon-7.png',
                      width: 25,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            ...moduleList.map((e) => CourseModule(e)).toList()
            //CourseModule(moduleList[0]),
          ],
        ));
  }
}

class CourseProgress1 extends StatelessWidget {
  final moduleList = Module1.generatemodule1();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'The Progress',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Image.network(
                      'https://cdn3.iconfinder.com/data/icons/faticons/32/grid-2-01-512.png',
                      width: 20,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      width: 185,
                      height: 25,
                      child: Image.asset(
                        'assets/images/list.png',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            ...moduleList.map((e) => CourseModule1(e)).toList()
            //CourseModule(moduleList[0]),
          ],
        ));
  }
}

class CourseProgress2 extends StatelessWidget {
  final moduleList = Module2.generatemodule2();
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'The Progress',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Image.network(
                      'https://cdn3.iconfinder.com/data/icons/faticons/32/grid-2-01-512.png',
                      width: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Image.network(
                      'https://www.freeiconspng.com/thumbs/list-icon/checklist-icon-checklist-icon-png-list-icon-7.png',
                      width: 25,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            ...moduleList.map((e) => CourseModule2(e)).toList()
            //CourseModule(moduleList[0]),
          ],
        ));
  }
}
