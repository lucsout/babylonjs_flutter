import 'dart:math';
import 'dart:ui';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty/customs/custom_applications.dart';

class LoginBackground extends StatelessWidget {
  int? backgroundAsset;

  LoginBackground({super.key, this.backgroundAsset});

  String getBackgroundName() {
    String assetName = 'assets/images/backgrounds/BACKGROUND_';

    var rng = Random();

    if (backgroundAsset != null) return '$assetName${backgroundAsset}.jpg';

    return '$assetName${rng.nextInt(5) + 1}.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            getBackgroundName(),
            fit: BoxFit.cover,
          )
              .animate()
              .fadeIn()
              .blur(
                  begin: const Offset(5, 5),
                  end: Offset.zero,
                  duration: 1350.ms,
                  curve: Curves.easeInOut)
              .animate(
                  onComplete: (controller) => controller.repeat(reverse: true))
              .scale(
                  curve: Curves.fastOutSlowIn,
                  begin: const Offset(1, 1),
                  end: const Offset(1.1, 1.1),
                  duration: 8000.ms),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
              height: context.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black54, Colors.transparent]))),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
              height: context.height * 0.45,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Colors.transparent,
                    Colors.black54,
                  ]))),
        ),
      ],
    );
  }
}
