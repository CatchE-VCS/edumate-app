import 'dart:convert';

import 'package:edumate/pages/newhome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/bottom_nav.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool value = false;
  final formKey = GlobalKey<FormState>();
  String name = "";
  bool changeButton = false;
  bool _passwordVisible = false;
  final nameController = TextEditingController();
  final collegeController = TextEditingController();
  final branchController = TextEditingController();
  final yearController = TextEditingController();

  final passwordController = TextEditingController();

  register() async {
    final email = FirebaseAuth.instance.currentUser!.email;
    final val = await http.post(
      Uri.parse('https://edumate-backend-tsn2.onrender.com/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "name": nameController.text,
        "email": email!,
        "year": yearController.text,
        "branch": branchController.text,
        "college": collegeController.text,
      }),
    );
  }

  Widget _circularContainer(
    double height,
    Color color, {
    Color borderColor = Colors.transparent,
    double borderWidth = 2,
  }) {
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
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    collegeController.dispose();
    branchController.dispose();
    yearController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x00000000),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
              ],
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              extendBody: true,
              bottomNavigationBar: BottomNav(context: context),
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => NewHomePage(),
                      ),
                    );
                    //Navigator.popUntil(context, ModalRoute.withName('/home'));
                    //Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                backgroundColor: Color(0x00ffffff),
                centerTitle: true,
                title: Text('Registration'),
              ),
              body: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Register for contest Updates !! $name",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 32.0,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nameController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.email,
                                color: Color(0xff9182DC),
                                textDirection: TextDirection.ltr,
                              ),
                              hintText: "Enter name",
                              labelText: "Name",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Name cannot be empty';
                              } else if (!RegExp(
                                r'^[\w ]{0,50}$',
                              ).hasMatch(value)) {
                                return 'Enter correct Name';
                              } else {
                                return null;
                              }
                            },
                            // onChanged: (value) {
                            //   name = value;
                            //
                            //   setState(() {});
                            //   },
                          ), // Name
                          SizedBox(height: 10),
                          TextFormField(
                            controller: collegeController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.book_sharp,
                                color: Color(0xff9182DC),
                                textDirection: TextDirection.ltr,
                              ),
                              hintText: "Enter college name",
                              labelText: "College",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'College Name cannot be empty';
                              } else if (!RegExp(
                                r'^[\w .]{0,50}$',
                              ).hasMatch(value)) {
                                return 'Enter correct College Name';
                              } else {
                                return null;
                              }
                            },
                            // onChanged: (value) {
                            //   name = value;
                            //
                            //   setState(() {});
                            //   },
                          ), // College
                          SizedBox(height: 10),
                          TextFormField(
                            controller: branchController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.menu_book_rounded,
                                color: Color(0xff9182DC),
                                textDirection: TextDirection.ltr,
                              ),
                              hintText: "Enter branch",
                              labelText: "Branch",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Branch cannot be empty';
                              } else if (!RegExp(
                                r'^[\w ]{0,50}$',
                              ).hasMatch(value)) {
                                return 'Enter correct Branch';
                              } else {
                                return null;
                              }
                            },
                            // onChanged: (value) {
                            //   name = value;
                            //
                            //   setState(() {});
                            //   },
                          ), // Branch
                          SizedBox(height: 10),
                          TextFormField(
                            controller: yearController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.email,
                                color: Color(0xff9182DC),
                                textDirection: TextDirection.ltr,
                              ),
                              hintText: "Enter Year",
                              labelText: "Year",
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'year cannot be empty';
                              } else if (!RegExp(
                                r'^[\w ]{0,50}$',
                              ).hasMatch(value)) {
                                return 'Enter correct Year';
                              } else {
                                return null;
                              }
                            },
                            // onChanged: (value) {
                            //   name = value;
                            //
                            //   setState(() {});
                            //   },
                          ),
                          SizedBox(height: 40.0),

                          ElevatedButton(
                            child: Text(
                              "Register",
                              style: TextStyle(fontSize: 20),
                            ),
                            style: TextButton.styleFrom(
                              minimumSize: Size(100, 40),
                            ),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                register();
                              }
                            },
                          ),
                          const SizedBox(height: 80.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
