import 'package:edumate/pages/your_classes/course_module.dart';
import 'package:edumate/pages/your_classes/module.dart';
import 'package:flutter/material.dart';

class CourseProgress extends StatelessWidget {
  static final moduleList = Module.generateModule();

  const CourseProgress({super.key});
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
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 5),
                  Image.network(
                    'https://cdn3.iconfinder.com/data/icons/faticons/32/grid-2-01-512.png',
                    width: 20,
                  ),
                  SizedBox(width: 3),
                  SizedBox(
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
          ...moduleList.map((e) => CourseModule(module: e)),
          //CourseModule(moduleList[0]),
        ],
      ),
    );
  }
}

class CourseProgress1 extends StatelessWidget {
  static final moduleList = Module1.generatemodule1();

  const CourseProgress1({super.key});
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
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 5),
                  Image.network(
                    'https://cdn3.iconfinder.com/data/icons/faticons/32/grid-2-01-512.png',
                    width: 20,
                  ),
                  SizedBox(width: 3),
                  SizedBox(
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
          ...moduleList.map((e) => CourseModule1(module1: e)),
          //CourseModule(moduleList[0]),
        ],
      ),
    );
  }
}

class CourseProgress2 extends StatelessWidget {
  static final moduleList = Module2.generatemodule2();

  const CourseProgress2({super.key});
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
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 5),
                  Image.network(
                    'https://cdn3.iconfinder.com/data/icons/faticons/32/grid-2-01-512.png',
                    width: 20,
                  ),
                  SizedBox(width: 3),
                  SizedBox(
                    width: 185,
                    height: 25,
                    child: Image.asset('assets/images/list.png'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 15),
          ...moduleList.map((e) => CourseModule2(e)),
          //CourseModule(moduleList[0]),
        ],
      ),
    );
  }
}
