import 'package:edumate/pages/newhome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/bottom_nav.dart';

class RegistrationPage extends StatefulWidget {


  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                backgroundColor: Color(0x00fffff),
                centerTitle: true,
                title: Text('Registration'),
              ),

            final formKey = GlobalKey<FormState>();
            String name = "";
            bool changeButton = false;
            bool _passwordVisible  = false;
            final emailController = TextEditingController();
            final passwordController = TextEditingController();

            @override
            void dispose() {
            emailController.dispose();
            passwordController.dispose();

            super.dispose();
            }
            @override
            void initState() {
            _passwordVisible = false;
            }

            Widget build(BuildContext context) {
            return Scaffold(
            body: SingleChildScrollView(
            child: Column(
            children: [
            SizedBox(height: 10,),
            Image.asset(
            "assets/images/homepage_pic.png",
            width: 300,
            height: 300,
            fit: BoxFit.cover,
            ),
            Text(
            "Welcome $name",
            style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 20.0,),
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
            child: Form(
            key: formKey,
            child: Column(
            children: [
            TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: Icon(
            Icons.email, color: Colors.deepPurple, textDirection: TextDirection.ltr,
            ),
            hintText: "Enter Email ID",
            labelText: "Email ID",
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
            if(value!.isEmpty ){
            return 'Email cannot be empty';
            } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)){
            return 'Enter correct email';
            } else {
            return null;
            }
            }
            // onChanged: (value) {
            //   name = value;
            //
            //   setState(() {});
            //   },
            ),// Email
            SizedBox(height: 10),
            TextFormField(
            obscureText: !_passwordVisible,
            controller: passwordController,
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixIcon: IconButton(
            icon: Icon(
            (_passwordVisible) ? Icons.visibility : Icons.visibility_off,
            color: Colors.deepPurple,
            ),
            onPressed: () {
            setState(() {
            _passwordVisible = !_passwordVisible;
            });
            },
            ),
            hintText: "Enter password",
            labelText: "Password",
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
            if(value!.isEmpty) {
            return 'Password cannot be empty';
            }
            else if(!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$&*]).{8,15}$').hasMatch(value)){
            return 'Enter a Strong Password (Atleast one upperCase, one lowercase, one digit and one special character)';
            }else {
            return null;
            }
            }
            ),// Password
            SizedBox(height: 40.0,),

            ElevatedButton(
            child: Text("Login", style: TextStyle(fontSize: 20)),
            style: TextButton.styleFrom(minimumSize: Size(100, 40)),
            onPressed: () {
            if (formKey.currentState!.validate()) {
            signIn();
            }
            },
            ),
            const SizedBox(height: 20.0,),
            ElevatedButton.icon(
            label: const Text('Sign In with Google', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            minimumSize: const Size(double.infinity, 50)
            ),
            icon: const FaIcon(FontAwesomeIcons.google, color: Colors.purpleAccent,),
            onPressed: () {
            final provider = Provider.of<GoogleSignInPage>(context, listen: false);
            provider.googleLogin().then((_) => Navigator.pushNamed(context, MyRoutes.homeRoute));
            },
            ),
            const SizedBox(height: 50.0,),
            InkWell(
            child: const Text("Forgot Password ?", style: TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.bold),),
            onTap: () {
            Navigator.pushNamed(context, MyRoutes.forgotRoute);
            }
            ),
            const SizedBox(height: 10.0,),
            Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text("Don't Have An Account ?    ", style: TextStyle(fontSize: 16),),
            InkWell(
            child: const Text("Sign Up", style: TextStyle(fontSize: 16, color: Colors.deepPurple, fontWeight: FontWeight.bold),),
            onTap: () {
            Navigator.pushNamed(context, MyRoutes.registerRoute);
            }
            ),
            ],
            ),
            ],
            ),
            ),
            )
            ],
            ),
            )
            );
            }
            Future signIn() async{
            showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(child: CircularProgressIndicator())
            );
            try {
            await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
            );
            }
            on FirebaseAuthException catch (e) {
            print(e);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message.toString()), backgroundColor: Colors.deepPurple,));
            }
            // Navigator.popUntil(context, (route) => MyRoutes.homeRoute.isEmpty);
            navigatorKey.currentState!.popUntil((route) => route.isFirst);
            }
            }
            ),
          ),
        )
    );
  }
}
