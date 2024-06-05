import 'package:easypay/screens/homepage.dart';
import 'package:easypay/screens/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return HomePage(user: snapshot.data!);
          } else {
            return LoginPage(showRegisterPage: toggleScreens);
          }
        },
      ),
    );
  }

  void toggleScreens() {
    // Implement this to toggle between login and register screens
  }
}

