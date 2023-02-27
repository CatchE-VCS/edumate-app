import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:edumate/state/auth/constants/constants.dart';
import 'package:edumate/state/auth/models/auth_result.dart';
import 'package:edumate/state/posts/typedefs/user_id.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() {
    devtools.log(this.toString());
  }
}

class Authenticator {
  final firebaseAuth = FirebaseAuth.instance;
  final facebookAuth = FacebookAuth.instance;
  UserId? get userId => firebaseAuth.currentUser?.uid;
  bool get isAuthenticated => userId != null;
  String get displayName => firebaseAuth.currentUser?.displayName ?? '';
  String? get email => firebaseAuth.currentUser?.email;

  Future<AuthResult> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken!.token;

    if (token == null) {
      // user has aborts the login flow
      return AuthResult.aborted;
    }

    // Create a credential from the access token
    final OAuthCredential oAuthCredential =
        FacebookAuthProvider.credential(token);

    try {
      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(oAuthCredential);

      // displayName = userCredential.user!.displayName;

      return AuthResult.successful;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;

      if (e.code == Constants.accountExistsWithDifferentCredential &&
          email != null &&
          credential != null) {
        final providers = await firebaseAuth.fetchSignInMethodsForEmail(email);
        providers.log();
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          firebaseAuth.currentUser?.linkWithCredential(credential);
          return AuthResult.successful;
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      // user has aborts the login flow
      return AuthResult.aborted;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      // Once signed in, return the UserCredential
      await firebaseAuth.signInWithCredential(credential);
      return AuthResult.successful;
    } on FirebaseAuthException catch (e) {
      if (e.code == Constants.accountExistsWithDifferentCredential) {
        // handle the error here
      } else if (e.code == 'invalid-credential') {
        // handle the error here
      }
      return AuthResult.failure;
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await facebookAuth.logOut();
  }
}
