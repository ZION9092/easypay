import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../firestore model/user_model.dart';
import 'homepage.dart';
import 'main.dart';

class RegisterController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var age = ''.obs;
  var isLoading = false.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  void signUp() async {
    if (email.value.isNotEmpty &&
        password.value.isNotEmpty &&
        confirmPassword.value.isNotEmpty &&
        firstName.value.isNotEmpty &&
        lastName.value.isNotEmpty &&
        age.value.isNotEmpty) {
      if (password.value == confirmPassword.value) {
        isLoading(true);
        try {
          // Create user
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email.value,
            password: password.value,
          );

          User? user = userCredential.user;
          if (user != null) {
            // Add user details to Firestore
            await addUserDetails(
              UserModel(
                email: user.uid,
                firstName: firstName.value.trim(),
                lastName: lastName.value.trim(),
                age: int.parse(age.value.trim()),
              ),
            );

            isLoading(false);
            Get.snackbar('Success', 'Registered successfully',
                snackPosition: SnackPosition.BOTTOM);

            // Navigate to the home page with the current user
            Get.to(() => HomePage(user: user));
          }
        } catch (e) {
          isLoading(false);
          Get.snackbar('Error', 'Registration failed: $e',
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'Passwords do not match',
            snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      Get.snackbar('Error', 'All fields are required',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> addUserDetails(UserModel user) async {
    try {
      await FirebaseFirestore.instance.collection('users').add(user.toMap());
    } catch (e) {
      Get.snackbar('Error', 'Failed to add user details: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

// ignore: use_key_in_widget_constructors
class RegisterPage extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());
  final VoidCallback showLoginPage;

  RegisterPage({super.key, required this.showLoginPage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            physics: const BouncingScrollPhysics(),
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Let's Get You Started!",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.anton().fontFamily,
                          wordSpacing: 3),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ClipOval(
                      child: Image.asset("assets/images/image7.jpg"),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      "PAY SALARIES WITH FEW CLICKS!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                          fontSize: 19,
                          fontFamily: GoogleFonts.anton().fontFamily,
                          wordSpacing: 1),
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 20),
                    TextField(
                      controller: registerController.firstNameController,
                      onChanged: (value) =>registerController.firstName.value = value,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "First Name",
                        hintStyle: const TextStyle(color: Colors.purpleAccent),
                        fillColor: const Color.fromARGB(255, 219, 202, 219),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: registerController.lastNameController,
                      onChanged: (value) =>
                         registerController.lastName.value = value,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Last Name",
                        hintStyle: const TextStyle(color: Colors.purpleAccent),
                        fillColor: const Color.fromARGB(255, 219, 202, 219),
                        filled: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: registerController.ageController,
                      onChanged: (value) =>
                          registerController.age.value = value,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Age",
                        hintStyle: const TextStyle(color: Colors.purpleAccent),
                        fillColor: const Color.fromARGB(255, 219, 202, 219),
                        filled: true,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: registerController.emailController,
                      onChanged: (value) =>
                          registerController.email.value = value,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Email",
                        hintStyle: const TextStyle(color: Colors.purpleAccent),
                        fillColor: const Color.fromARGB(255, 219, 202, 219),
                        filled: true,
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: registerController.passwordController,
                      onChanged: (value) =>
                          registerController.password.value = value,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.purpleAccent),
                        fillColor: const Color.fromARGB(255, 219, 202, 219),
                        filled: true,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: registerController.confirmPasswordController,
                       onChanged: (value) => registerController.confirmPassword.value = value,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(color: Colors.purpleAccent),
                        fillColor: const Color.fromARGB(255, 219, 202, 219),
                        filled: true,
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    Obx(() => registerController.isLoading.value
                        ? const CircularProgressIndicator()
                        : GestureDetector(
                            onTap: registerController.signUp,
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Get.to(LoginPage(showRegisterPage: () {})),
                          child: const Text(
                            "Login here",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
