import 'dart:math';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sporty/controllers/menu_controller.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({super.key});

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> with TickerProviderStateMixin {
  MainMenuController menu = Get.find();
  SocioController socio = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildHeaderSocio() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRect(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Ciao 👋',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        color: Colors.black)),
                Text(socio.socio!.nominativo!,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 24,
                        color: Colors.black)),
              ],
            ).animate(delay: 150.ms).fadeIn().slideY(
                begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo),
          ),
          Expanded(
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              _buildQRCode(),
            ]),
          )
        ]);
  }

  Widget _buildNotificationIcon() {
    return GestureDetector(
      onTap: () {},
      child: const Icon(
        EvaIcons.bellOutline,
        size: 32,
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            EvaIcons.arrowBackOutline,
            size: 32,
          ),
        ).animate(delay: 150.ms).fadeIn().slideY(
            begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo),
      ],
    );
  }

  Widget _buildQRCode() {
    return ClipRRect(
      child: QrImage(
        data: socio.socio!.codTessera!,
        version: QrVersions.auto,
        size: 110.0,
      ).animate(delay: 250.ms).fadeIn().scale(
          begin: const Offset(0.50, 0.50),
          end: const Offset(1, 1),
          duration: 850.ms,
          curve: Curves.easeOutExpo),
    );
  }

  Widget _buildNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('📰 Bacheca',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black))
                .animate(delay: 200.ms)
                .fadeIn()
                .slideY(
                    begin: 1,
                    end: 0,
                    duration: 850.ms,
                    curve: Curves.easeOutExpo),
          ],
        ),
        10.heightBox,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              _buildHeader(),
              45.heightBox,
              Text('Utilizza il QRCode per accedere alla palestra:',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: Colors.black))
                  .animate(delay: 200.ms)
                  .fadeIn()
                  .slideY(
                      begin: 1,
                      end: 0,
                      duration: 850.ms,
                      curve: Curves.easeOutExpo),
              15.heightBox,
              ClipRRect(
                child: QrImage(
                  data: socio.socio!.codTessera!,
                  version: QrVersions.auto,
                  size: 250.0,
                ).animate(delay: 250.ms).fadeIn().scale(
                    begin: const Offset(0.50, 0.50),
                    end: const Offset(1, 1),
                    duration: 850.ms,
                    curve: Curves.easeOutExpo),
              ),
            ],
          ),
        ));
  }
}
