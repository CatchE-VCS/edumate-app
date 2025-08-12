import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Authentication controller that handles Firebase Auth operations
/// including email/password authentication, Google Sign-In, and password reset.
class AuthController {
  final firebaseAuth = FirebaseAuth.instance;
  
  /// Stream that provides authentication state changes
  Stream<User?> get authChanges => firebaseAuth.authStateChanges();

  /// Sends a password reset email to the specified email address
  /// Returns 'success' if email was sent, or error message if failed
  Future<String> sendPasswordResetEmail(String email) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        result = 'success';
      } else {
        result = 'Email field must not be empty';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

//   validatePassword(String pass) {
//     // ^ represents starting character of the string.
// // (?=.*[0-9]) represents a digit must occur at least once.
// // (?=.*[a-z]) represents a lower case alphabet must occur at least once.
// // (?=.*[A-Z]) represents an upper case alphabet that must occur at least once.
// // (?=.*[@#$%^&-+=()] represents a special character that must occur at least once.
// // (?=\\S+$) white spaces don’t allowed in the entire string.
// // .{8, 20} represents at least 8 characters and at most 20 characters.
// // $ represents the end of the string.
//     bool passValid =
//         RegExp(r"^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[@#$%^&-+=()]).{8,20}$")
//             .hasMatch(pass);
//     if (!(passValid)) {
//       return "Must have at least one lowercase, one uppercase , one number, one special character and length at least 8";
//     }

//     return "strong";
//   }

  // validateEmail(String email) {
  //   bool emailValid = RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(email);
  //   return emailValid;
  // }

  /// Handles Google Sign-In authentication
  /// Returns 'success', 'new_user', or error message
  Future<String> signInWithGoogle() async {
    String result = 'Some error occurred';
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      GoogleSignInAccount? googleUser = await googleSignIn.authenticate();
      GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          //store user details in firestore
          // // firebaseFirestore.collection('users').doc(user.uid).set({
          //   'fname': user.displayName,
          //   'username': user.email,
          //   'uid': user.uid,
          //   'email': user.email,
          //   'userImage': user.photoURL,
          // });
          result = "new_user";
          return result;
        }
      }
      result = 'success';
    } on FirebaseAuthException catch (e) {
      print(e);
    } catch (e) {
      result = e.toString();
    }
    return result;
  }

  /// Creates a new user account with email and password
  /// Returns 'success' if account was created, or error message if failed
  Future<String> signUpUser(String email, String password, String firstName) async {
    String result = 'Some error occurred';
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String downloadUrl;
      // if (image != null) {
      // downloadUrl = await _uploadImageToStorage(image);
      // } else {
      downloadUrl = '';
      // }
      // User? user = userCredential.user;
      await userCredential.user!.sendEmailVerification();
      if (userCredential.additionalUserInfo!.isNewUser) {
        //store user details in firestore
        // firebaseFirestore
        //     .collection('users')
        //     .doc(userCredential.user!.uid)
        //     .set({
        //   'fname': fname,
        //   'uid': userCredential.user!.uid,
        //   'email': email,
        //   'userImage': downloadUrl,
        // });
      }
      result = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        result = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        result = 'The account already exists for that email.';
      }
    } catch (e) {
      result = e.toString();
    }
    // print(res);
    return result;
  }

  Future<String> signInWithEmailPassword(String email, String password) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        result = 'success';
      } else {
        result = 'Fields must not be empty';
      }

      // print("Signed in");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        result = 'Incorrect password';
      }
    } catch (e) {
      result = e.toString();
    }
    return result;
  }
  // git client secret 0a443c074eb2a80e4e060483b4695feeaabc533d

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("Signed Out");
    } on FirebaseAuthException catch (e) {
      // if (e.code == 'user-not-found') {
      print(e.code);
      // } else if (e.code == 'wrong-password') {
      // print('Wrong password provided for that user.');
    }
  }
}

void showSnackBarr(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(content)),
  );
}

