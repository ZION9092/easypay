import 'package:easypay/Onboarding/onboarding_screen.dart';
import 'package:easypay/mainpage.dart';
import 'package:easypay/screens/forgotpassword.dart';
import 'package:easypay/screens/registrationpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Pay',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => OnboardingScreen()),
        GetPage(name: '/login', page: () => LoginPage(showRegisterPage: () {})),
        GetPage(name: '/register', page: () => RegisterPage(showLoginPage: () {})),
        GetPage(name: '/forgotpassword', page: () => Forgotpassword()),
        GetPage(name: '/home', page: () => MainPage(user: Get.arguments,)), // Add the home screen route
        // Add other pages here
      ],
    );
  }
}


class LoginController extends GetxController {
  var email = ''.obs;
  var password = ''.obs;
  var isLoading = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() async {
    try {
      if (email.value.isNotEmpty && password.value.isNotEmpty) {
        isLoading(true);
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.value,
          password: password.value,
        );
        isLoading(false);
        // Navigate to the home page
         Get.offAllNamed('/home', arguments: userCredential.user);
        Get.snackbar('Success', 'Logged in successfully',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Error', 'Email and password cannot be empty',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      isLoading(false);
      Get.snackbar('Error', 'Failed to login: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

// ignore: use_key_in_widget_constructors
class LoginPage extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());
  final VoidCallback showRegisterPage;
  LoginPage({super.key, required this.showRegisterPage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            physics: const BouncingScrollPhysics(),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipOval(
                    child: Image.asset(
                      "assets/images/epay icon.jpg",
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Welcome Administrator!",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    onChanged: (value) => loginController.email.value = value,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
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
                    onChanged: (value) =>
                        loginController.password.value = value,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.deepPurple),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Password",
                      hintStyle: const TextStyle(color: Colors.purpleAccent),
                      fillColor: const Color.fromARGB(255, 219, 202, 219),
                      filled: true,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 5),
                  Padding(padding: const EdgeInsets.symmetric(horizontal: 25)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(Forgotpassword());
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Obx(() => loginController.isLoading.value
                      ? const CircularProgressIndicator()
                      : GestureDetector(
                          onTap: loginController.login,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 24),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 219, 202,
                                  219), // Change to your preferred color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  color: Colors
                                      .purpleAccent, // Change to your preferred text color
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New to Easy Pay?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(RegisterPage(
                          showLoginPage: () {},
                        )),
                        child: const Text(
                          "Register here",
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
            ],
          ),
        ),
      ),
    );
  }
}
