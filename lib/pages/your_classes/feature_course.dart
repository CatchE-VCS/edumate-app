import 'package:edumate/pages/your_classes/category_title.dart';
import 'package:edumate/pages/your_classes/course.dart';
import 'package:edumate/pages/your_classes/course_item.dart';
import 'package:flutter/material.dart';

class FeatureCourse3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitle('Assistant', ' '),

        // ignore: sized_box_for_whitespace
        ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => MyHomePage(
            //               title: 'edumate',
            //             )));
          },
          child: Text('Open'),
        ),
      ],
    );
  }
}

class FeatureCourse extends StatelessWidget {
  final coursesList = Course.generateCourses();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitle('Mobile App Developer', 'View All'),

        Container(
          decoration: BoxDecoration(),
          height: 300,
          child: ListView.separated(
            padding: const EdgeInsets.all(25),
            scrollDirection: Axis.horizontal,
            itemCount: coursesList.length,
            itemBuilder: (context, index) =>
                CourseItem(course: coursesList[index]),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
          ),
        ),
      ],
    );
  }
}

class FeatureCourse1 extends StatelessWidget {
  final coursesList1 = Course1.generateCourses1();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitle('Web Developer', 'View All'),
        SizedBox(
          height: 300,
          child: ListView.separated(
            padding: const EdgeInsets.all(25),
            scrollDirection: Axis.horizontal,
            itemCount: coursesList1.length,
            itemBuilder: (context, index) => CourseItem1(coursesList1[index]),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
          ),
        ),
      ],
    );
  }
}

class FeatureCourse2 extends StatelessWidget {
  final coursesList2 = Course2.generateCourses2();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitle('Programmer', 'View All'),
        // ignore: sized_box_for_whitespace
        Container(
          height: 300,
          child: ListView.separated(
            padding: const EdgeInsets.all(25),
            scrollDirection: Axis.horizontal,
            itemCount: coursesList2.length,
            itemBuilder: (context, index) => CourseItem2(coursesList2[index]),
            separatorBuilder: (context, index) => const SizedBox(width: 15),
          ),
        ),
      ],
    );
  }
}
