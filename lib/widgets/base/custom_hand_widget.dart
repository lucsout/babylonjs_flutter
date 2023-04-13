import 'dart:convert';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';

class CustomHandWidget extends StatefulWidget {
  const CustomHandWidget({super.key});

  @override
  State<CustomHandWidget> createState() => _CustomHandWidgetState();
}

class _CustomHandWidgetState extends State<CustomHandWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int times = 0;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);

    Future.delayed(5000.ms, () {
      if (!isDisposed && mounted) {
        _animationController.forward();
      }

      _animationController.addListener(() async {
        if (times < 2) {
          if (_animationController.isCompleted && !isDisposed && mounted) {
            _animationController.reverse();
            times++;
          }
          if (_animationController.isDismissed && !isDisposed && mounted) {
            _animationController.forward();
          }
        } else {
          await Future.delayed(15000.ms);
          times = 0;

          if (_animationController.isDismissed && !isDisposed && mounted) {
            _animationController.forward();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    isDisposed = true;
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text('👋',
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black))
        .animate(
          autoPlay: false,
          controller: _animationController,
        )
        .rotate(
            duration: 200.ms, curve: Curves.easeInOutQuad, begin: 0, end: 0.2);
  }
}
