import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_social_media/pages/login_page.dart';

import '../pages/home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Loading indicator while waiting for authentication state
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Error handling if something goes wrong
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data is User) {
            // User is logged in
            return HomePage();
          } else {
            // User is not logged in
            return LoginPage();
          }
        },
      ),
    );
  }
}
