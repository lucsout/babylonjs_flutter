import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../pages/home/home_screen.dart';

class MainMenuController extends GetxController {
  Rx<Widget> currentScreen = (HomeScreen() as Widget).obs;
  Rx<String?> currentMenuString = 'Home'.obs;

  late AnimationController controller;
  late AnimationController controllerAllAnimations;
  late AnimationController controllerRadius;
  late Animation<BorderRadius?> borderRadiusAnimation;

  Rx<Curve> reverseCurve = Curves.fastLinearToSlowEaseIn.flipped.obs;
  bool opened = false;

  MainMenuController();

  void toggleMenu() {
    if (!opened) {
      reverseCurve.value = reverseCurve.value.flipped;

      controller.forward();
      controllerRadius.forward();
      controllerAllAnimations.forward();

      opened = true;
    } else {
      reverseCurve.value = reverseCurve.value.flipped;

      controller.reverse();
      controllerRadius.reverse();
      controllerAllAnimations.reverse();

      opened = false;
    }
  }

  Widget getScreen(String page) {
    switch (page) {
      case '/home':
        return const HomeScreen();
      default:
        return const HomeScreen();
    }
  }
}
