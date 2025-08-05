import 'package:edumate/state/auth/backend/auth_controller.dart';
import 'package:edumate/pages/newhome.dart';
import 'package:edumate/pages/registration_page.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = AuthController();
  String isOpened = "No";
  int hey = 0;
  signInWithGoogle() async {
    // setState(() {
    //   _isLoading = true;
    // });
    String res = await _authController.signInWithGoogle();
    if (res != 'success') {
      // setState(() {
      //   _isLoading = false;
      // });
      if (!mounted) return;
      showSnackBarr(res, context);
      if (res == "new user") {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const RegistrationPage()));
      }
    } else {
      if (!mounted) return;
      showSnackBarr(
          'Congratulations you have been successfully signed in..', context);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NewHomePage()));
    }
  }

  go() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => NewHomePage()));
  }

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Lottie.asset('assets/images/learning.json')],
        ),
        floatingActionButton: Builder(
          builder: (context) => FabCircularMenu(
            alignment: Alignment.bottomRight,
            ringColor: Colors.red.withOpacity(0.0),
            ringDiameter: 250.0,
            ringWidth: 60.0,
            fabSize: 60.0,
            fabElevation: 15.0,
            fabColor: Colors.white,
            fabOpenIcon:
                CircleAvatar(child: Image.asset('assets/images/icon.jpeg')),
            fabCloseIcon: Icon(Icons.close, color: Colors.red),
            fabMargin: const EdgeInsets.all(20.0),
            animationDuration: const Duration(milliseconds: 800),
            animationCurve: Curves.easeInOutCirc,
            onDisplayChange: (isOpen) {
              if (isOpen) {
                setState(() {
                  isOpened = "Yes";
                });
              } else {
                setState(() {
                  isOpened = "No";
                });
              }
            },
            children: [
              SizedBox(
                height: 250,
                width: 500,
              ),
              FloatingActionButton(
                  mini: false,
                  backgroundColor: Colors.white,
                  heroTag: "Facebook",
                  child: Icon(
                    Icons.facebook,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    go();
                    // Navigator.pushReplacement(context,
                    // MaterialPageRoute(builder: (context) => NewHomePage()));
                  }),
              SizedBox(
                height: 500,
                width: 500,
              ),
              FloatingActionButton(
                backgroundColor: Colors.white,
                mini: false,
                heroTag: "Google",
                child: Container(
                    child: CircleAvatar(
                        child: Image.asset('assets/images/google.png'))),
                onPressed: () {
                  setState(() {
                    signInWithGoogle();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
