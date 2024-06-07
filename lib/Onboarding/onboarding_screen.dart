import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'onboarding_controller.dart';

// ignore: use_key_in_widget_constructors
class OnboardingScreen extends StatelessWidget {
  final OnboardingController onboardingController = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: onboardingController.pageController,
              onPageChanged: onboardingController.onPageChanged,
              children: const [
                OnboardingPage(
                  animation: 'assets/animations/lottie 3.json',
                  title: 'Welcome to Easy Pay',
                  description: 'Easily manage your salary payments and history.',
                ),
                OnboardingPage(
                  animation: 'assets/animations/lottie 2.json',
                  title: 'Track Your Payments',
                  description: 'Get detailed information about your salary transactions.',
                ),
                OnboardingPage(
                  animation: 'assets/animations/lottie 1.json',
                  title: 'Manage Your Account',
                  description: 'Update your profile and payment settings easily.',
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => buildDot(index, context, onboardingController)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: onboardingController.nextPage,
              child: Text(onboardingController.currentIndex.value == 2 ? 'Get Started' : 'Next'),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(int index, BuildContext context, OnboardingController controller) {
    return Container(
      height: 50,
      width: 10,
      margin: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: controller.currentIndex.value == index ? Colors.deepPurple : Colors.grey,
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String animation;
  final String title;
  final String description;

  const OnboardingPage({super.key, required this.animation, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation,
           height: 300,
           fit: BoxFit.cover,
           
           ), // Ensure you have the animations in assets folder
          const SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
