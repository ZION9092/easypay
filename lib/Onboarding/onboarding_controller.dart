import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  var currentIndex = 0.obs;
  var pageController = PageController();

  void nextPage() {
    if (currentIndex.value == 2) {
      Get.offAllNamed('/login');
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}
