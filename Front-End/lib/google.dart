import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInDemo extends StatefulWidget {
  @override
  _SignInDemoState createState() => _SignInDemoState();
}

class _SignInDemoState extends State<SignInDemo> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _handleSignIn() async {
    try {
      GoogleSignInAccount? account = await _googleSignIn.signOut();
      account = await _googleSignIn.signIn();
      GoogleSignInAuthentication authentication = await account!.authentication;

      if (account != null) {
        print(authentication.accessToken);
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Sign-In Demo')),
      body: Center(
        child: ElevatedButton(
          onPressed: _handleSignIn,
          child: Text('Sign In with Google'),
        ),
      ),
    );
  }
}
