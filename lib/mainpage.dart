import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  final User? user;

  const MainPage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${user?.email ?? 'User'}!'), // Display the user's email
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed('/login');
              },
              child: Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}


  void toggleScreens() {
  }


