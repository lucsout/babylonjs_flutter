import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty/controllers/login_controller.dart';
import 'package:sporty/controllers/menu_controller.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/pages/corsi/corsi_screen.dart';
import 'package:sporty/pages/gallery/gallery_screen.dart';
import 'package:sporty/pages/home/home_screen.dart';
import 'package:sporty/pages/prenota/prenota_screen.dart';
import 'package:sporty/pages/profilo/profilo_screen.dart';
import 'package:sporty/widgets/base/custom_hand_widget.dart';
import 'package:transparent_image/transparent_image.dart';

import '../widgets/base/custom_foto_widget.dart';
import 'prenotazioni/le_mie_prenotazioni_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  MainMenuController menu = Get.find();
  SocioController socio = Get.find();
  LoginController login = Get.find();

  @override
  void initState() {
    super.initState();

    menu.controller = AnimationController(vsync: this, duration: 850.ms);
    menu.controllerAllAnimations =
        AnimationController(vsync: this, duration: 850.ms);

    menu.controllerRadius = AnimationController(
      duration: const Duration(milliseconds: 450),
      vsync: this,
    );

    menu.borderRadiusAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(0.0),
      end: BorderRadius.circular(20.0),
    ).animate(menu.controllerRadius);
  }

  @override
  void dispose() {
    menu.controller.dispose();
    menu.controllerAllAnimations.dispose();
    menu.controllerRadius.dispose();

    super.dispose();
  }

  Widget _buildHeaderMenu() {
    return Row(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
                  padding: (socio.socio != null &&
                          socio.socio!.foto != null &&
                          socio.socio!.foto!.isNotEmpty)
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.all(10),
                  child: (socio.socio != null &&
                          socio.socio!.foto != null &&
                          socio.socio!.foto!.isNotEmpty)
                      ? CustomFotoSocioWidget()
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                              width: 65,
                              height: 65,
                              color: Colors.white,
                              child: const Icon(EvaIcons.personOutline,
                                  size: 36))))
              .animate(
                  autoPlay: false, controller: menu.controllerAllAnimations)
              .fadeIn()
              .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  duration: 850.ms,
                  curve: Curves.easeOutExpo),
          15.widthBox,
          ClipRect(
            child: SizedBox(
              width: Get.width * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Ciao ',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black)),
                      const CustomHandWidget(),
                    ],
                  ),
                  if (socio.socio != null)
                    AutoSizeText(socio.socio!.nominativo!,
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.black)),
                  if (socio.socio == null)
                    Text('Effettua il login',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.black)),
                ],
              )
                  .animate(
                      autoPlay: false, controller: menu.controllerAllAnimations)
                  .fadeIn()
                  .slideY(
                      begin: 1,
                      end: 0,
                      duration: 850.ms,
                      curve: Curves.easeOutExpo),
            ),
          )
        ],
      )
    ]);
  }

  Widget _buildToggleMenu() {
    return GestureDetector(
      onTap: () {
        MainMenuController menu = Get.find();
        menu.toggleMenu();
      },
      child: const Icon(
        EvaIcons.menu,
        size: 32,
      ),
    );
  }

  Widget _buildMenuItem(int index, String name, IconData icon, Widget screen) {
    return ClipRRect(
      child: GestureDetector(
        onTap: () {
          if (screen is Container) {
            Get.offAllNamed('/login');
          } else {
            menu.currentMenuString.value = name;
            menu.currentScreen.value = screen;

            menu.toggleMenu();
          }
        },
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: Get.width * 0.68,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: menu.currentMenuString.value == name
                        ? CustomApplication.menuSelected
                        : Colors.transparent),
                child: Row(
                  children: [
                    10.widthBox,
                    Icon(icon,
                        size: 24,
                        color: menu.currentMenuString.value == name
                            ? CustomApplication.menuTextSelected
                            : Colors.black54),
                    15.widthBox,
                    Text(name,
                        style: GoogleFonts.poppins(
                            fontWeight: menu.currentMenuString.value == name
                                ? FontWeight.bold
                                : FontWeight.w300,
                            fontSize: 14,
                            color: menu.currentMenuString.value == name
                                ? CustomApplication.menuTextSelected
                                : Colors.black)),
                  ],
                )),
          ],
        ),
      )
          .animate(autoPlay: false, controller: menu.controllerAllAnimations)
          .fadeIn(delay: (65 * index).ms)
          .slideY(
              delay: (65 * index).ms,
              begin: 1,
              end: 0,
              duration: 850.ms,
              curve: Curves.easeOutExpo),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, Get.width - (Get.width * 0.85), 0),
          child: Container(
            width: 200,
            height: 100,
            padding: const EdgeInsets.all(5),
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Image.network(
              'https://app.edilab.it/ImagesApp/SPORTY/${login.appID!}/logo.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenu() {
    return Positioned.fill(
      child: Padding(
          padding: const EdgeInsets.all(30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            15.heightBox,
            _buildToggleMenu(),
            10.heightBox,
            _buildHeaderMenu(),
            35.heightBox,
            _buildMenuItem(1, 'Home', EvaIcons.homeOutline, const HomeScreen()),
            _buildMenuItem(
                2, 'Corsi', EvaIcons.layoutOutline, const CorsiScreen()),
            if (socio.socio != null)
              _buildMenuItem(3, 'Prenota', EvaIcons.calendarOutline,
                  const PrenotaScreen()),
            if (socio.socio != null)
              _buildMenuItem(3, 'Le mie prenotazioni',
                  FontAwesomeIcons.bookmark, const LeMiePrenotazioniScreen()),
            _buildMenuItem(
                4, 'Gallery', EvaIcons.cameraOutline, const GalleryScreen()),
            if (socio.socio != null)
              _buildMenuItem(
                  5, 'Profilo', EvaIcons.personOutline, const ProfiloScreen()),
            if (socio.socio == null)
              _buildMenuItem(
                  6, 'Ritorna al login', EvaIcons.logOutOutline, Container()),
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [_buildLogo()]),
            )
          ])),
    );
  }

  Widget _buildScreen() {
    return Positioned.fill(
        child: GestureDetector(
            onTap: () {},
            child: AnimatedBuilder(
                animation: menu.controllerRadius,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          blurRadius: 25,
                          color: Colors.blueGrey.withOpacity(0.05),
                          spreadRadius: 15)
                    ]),
                    child: ClipRRect(
                        borderRadius: menu.borderRadiusAnimation.value,
                        child: child),
                  );
                },
                child: menu.currentScreen.value)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomApplication.backgroundColor,
        body: Stack(
          children: [
            Obx(() => _buildMenu()),
            Obx(
              () => _buildScreen()
                  .animate(controller: menu.controller, autoPlay: false)
                  .slide(
                      curve: menu.reverseCurve.value,
                      duration: 850.ms,
                      begin: const Offset(0, 0),
                      end: const Offset(0.90, 0))
                  .scale(
                    curve: menu.reverseCurve.value,
                    begin: const Offset(1, 1),
                    end: const Offset(0.80, 0.80),
                    duration: 850.ms,
                  ),
            )
          ],
        ));
  }
}
