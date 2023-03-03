import 'package:edumate/pages/yourclasses/course.dart';
import 'package:edumate/pages/yourclasses/courseDesc.dart';
import 'package:edumate/pages/yourclasses/courseProgress.dart';
import 'package:edumate/pages/yourclasses/customAppBar.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final Course course;
  DetailPage(this.course);
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
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(course),
                CourseDescription(course),
                CourseProgress(),
              ],
            ),
          )),
    );
  }
}

class DetailPage1 extends StatelessWidget {
  final Course1 course1;
  DetailPage1(this.course1);
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
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar1(course1),
                CourseDescription1(course1),
                CourseProgress1(),
              ],
            ),
          )),
    );
  }
}

class DetailPage2 extends StatelessWidget {
  final Course2 course2;
  DetailPage2(this.course2);
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
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar2(course2),
                CourseDescription2(course2),
                CourseProgress2(),
              ],
            ),
          )),
    );
  }
}
