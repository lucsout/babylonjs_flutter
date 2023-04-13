import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporty/controllers/menu_controller.dart';
import 'package:sporty/models/corso.dart';
import 'package:sporty/pages/corsi/detail_corsi_screen.dart';
import 'package:sporty/widgets/base/custom_header_widget.dart';

import '../../controllers/corsi_controller.dart';
import '../../customs/custom_applications.dart';
import '../../models/news.dart';
import '../../widgets/base/custom_calendar_widget.dart';
import '../../widgets/base/custom_future_builder.dart';
import "package:collection/collection.dart";

import '../../widgets/base/custom_search_widget.dart';
import '../../widgets/base/custom_title_widget.dart';

class PrenotaScreen extends StatefulWidget {
  const PrenotaScreen({super.key});

  @override
  State<PrenotaScreen> createState() => _PrenotaScreenState();
}

class _PrenotaScreenState extends State<PrenotaScreen>
    with TickerProviderStateMixin {
  CorsiController corsi = Get.find();
  RxString isFiltering = ''.obs;

  late Future<List<Corso>> corsiFuture;
  List<Corso> corsiLoaded = [];

  ScrollController scroll = ScrollController();

  @override
  void initState() {
    super.initState();

    corsiFuture = corsi.getCorsi();
  }

  @override
  void dispose() {
    scroll.dispose();

    super.dispose();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            MainMenuController menu = Get.find();
            menu.toggleMenu();
          },
          child: const Icon(
            EvaIcons.menu,
            size: 32,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  HeaderWidget(),
                  20.heightBox,
                  AutoSizeText('Seleziona il giorno e prenota la tua lezione!',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              height: 1.2,
                              fontWeight: FontWeight.w300,
                              fontSize: 18,
                              color: Colors.black87))
                      .animate(delay: 150.ms)
                      .fadeIn()
                      .slideY(
                          begin: 1,
                          end: 0,
                          duration: 850.ms,
                          curve: Curves.easeOutExpo),
                  20.heightBox,
                  CustomCalendarWidget(
                          rangeFrom: DateTime.now(),
                          rangeTo: DateTime.now()
                              .toUtc()
                              .add(const Duration(days: 30)))
                      .animate(delay: 250.ms)
                      .fadeIn()
                      .slideY(
                          begin: 0.2,
                          end: 0,
                          duration: 850.ms,
                          curve: Curves.easeOutExpo),
                  10.heightBox,
                ],
              ),
            ),
          ),
        ));
  }
}
