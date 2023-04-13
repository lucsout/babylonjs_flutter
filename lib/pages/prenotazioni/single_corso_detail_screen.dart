import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sporty/controllers/corsi_controller.dart';
import 'package:sporty/controllers/menu_controller.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/models/corso_booking.dart';
import 'package:sporty/widgets/base/custom_button_widget.dart';
import 'package:sporty/widgets/base/custom_header_widget.dart';
import 'package:sporty/widgets/dialogs/dialog_error.dart';
import 'package:sporty/widgets/dialogs/dialog_yesno.dart';

import '../../models/corso.dart';
import '../../widgets/dialogs/dialog_success.dart';

class SingleCorsoDetailScreen extends StatefulWidget {
  SingleCorsoDetailScreen({super.key});

  @override
  State<SingleCorsoDetailScreen> createState() =>
      _SingleCorsoDetailScreenState();
}

class _SingleCorsoDetailScreenState extends State<SingleCorsoDetailScreen>
    with TickerProviderStateMixin {
  CorsoBooking? corso;

  MainMenuController menu = Get.find();
  SocioController socio = Get.find();
  CorsiController corsoController = Get.find();

  @override
  void initState() {
    super.initState();

    corso = Get.arguments as CorsoBooking;
  }

  Widget _buildNomeCorso() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(corso!.courseName ?? '',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black87))
                  .animate(delay: 200.ms)
                  .fadeIn()
                  .slideY(
                      begin: 1,
                      end: 0,
                      duration: 850.ms,
                      curve: Curves.easeOutExpo),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(corso!.name ?? '',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          color: Colors.black87))
                  .animate(delay: 200.ms)
                  .fadeIn()
                  .slideY(
                      begin: 1,
                      end: 0,
                      duration: 850.ms,
                      curve: Curves.easeOutExpo),
            ],
          ),
        ]);
  }

  Widget _buildStat(IconData icon, String tipo, String data, String color,
      String colorText, int index) {
    return Row(
      children: [
        Container(
          width: 65,
          height: 65,
          decoration: BoxDecoration(
              color: HexColor(color), borderRadius: BorderRadius.circular(22)),
          child: Icon(icon, size: 24, color: HexColor(colorText)),
        ),
        30.widthBox,
        Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tipo,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black87)),
              Text(data,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87))
            ])
      ],
    )
        .animate(delay: (250 + (index * 80)).ms)
        .fadeIn()
        .slideY(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
  }

  String getStringaOrario(String? oraInizio, String? oraFine) {
    return '${oraInizio!.substring(0, 5)} - ${oraFine!.substring(0, 5)}';
  }

  Widget _buildIconSocio(IconData icon, String desc, String data, int index) {
    return Container(
            height: 110,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
                color: CustomApplication.backgroundColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, size: 24, color: Colors.black87),
                AutoSizeText(data,
                    maxLines: 1,
                    minFontSize: 4,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black87)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(desc,
                        maxLines: 1,
                        minFontSize: 4,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 14,
                            color: Colors.black)),
                  ],
                ),
              ],
            ))
        .animate(delay: (350 + (index * 60)).ms)
        .fadeIn()
        .slideX(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
  }

  Widget _buildPosti() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Flexible(
            fit: FlexFit.tight,
            child: _buildIconSocio(FontAwesomeIcons.personRunning, 'Posti',
                corso!.bookingOption!.available.toString(), 1),
          ),
          10.widthBox,
          Flexible(
            fit: FlexFit.tight,
            child: _buildIconSocio(FontAwesomeIcons.check, 'Iscritti',
                corso!.bookingOption!.booked.toString(), 2),
          ),
          10.widthBox,
          Flexible(
              fit: FlexFit.tight,
              child: _buildIconSocio(FontAwesomeIcons.peopleLine, 'In riserva',
                  corso!.bookingOption!.queue.toString(), 5)),
        ]),
      ],
    );
  }

  String getStringaBadge() {
    if (corso!.bookingOption!.userStatus == 'booked') {
      return 'Sei già prenotato a questo corso.';
    } else if (corso!.bookingOption!.userStatus == 'enqueued') {
      return 'Sei già prenotato in RISERVA';
    } else {
      return '${(corso!.bookingOption!.available! - corso!.bookingOption!.booked!)} posti disponibili';
    }
  }

  Widget _buildInfoBadge() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: AutoSizeText(getStringaBadge(),
                maxLines: 2,
                minFontSize: 4,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black)),
          )
        ]);
  }

  Color getColorButton() {
    if (corso!.bookingOption!.userStatus == 'booked' ||
        corso!.bookingOption!.userStatus == 'enqueued') {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }

  String getTextButton() {
    if (corso!.bookingOption!.userStatus == 'booked') {
      return 'Annulla prenotazione';
    }
    if (corso!.bookingOption!.userStatus == 'enqueued') {
      return 'Annulla riserva';
    } else {
      return 'Prenota';
    }
  }

  Future prenotaButton() async {
    if (corso!.bookingOption!.userStatus == 'booked' ||
        corso!.bookingOption!.userStatus == 'enqueued') {
      await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => DialogYesNo(
              text: corso!.bookingOption!.userStatus == 'enqueued'
                  ? 'Sei sicuro di voler annullare la tua riserva?'
                  : 'Sei sicuro di voler annullare la tua prenotazione?',
              onYes: () async {
                await prenotaAnnulla();
              }));
    } else {
      if (context.mounted) {
        await prenotaAnnulla();
      }
    }

    await reloadCorso();
    setState(() {});

    SmartDialog.dismiss();
  }

  Future prenotaAnnulla() async {
    var resultString = "";

    if (corso!.bookingOption!.userStatus == "available") {
      resultString =
          await socio.prenotaLezione(corso!.uniqueid!, corso!.itemid!);
    } else {
      resultString =
          await socio.annullaLezione(corso!.uniqueid!, corso!.itemid!);
    }

    if (resultString.contains('OK')) {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (context) =>
                DialogSuccess(resultString.replaceAll('OK-', '')));
      }
    } else {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (context) =>
                DialogError(resultString.replaceAll('KO-', '')));
      }
    }
  }

  Future reloadCorso() async {
    var corsoReloaded =
        await corsoController.getSingleCorso(int.parse(corso!.itemid!));

    corso = corsoReloaded;
  }

  Widget _buildButton() {
    return CustomButtonWidget(
      text: getTextButton(),
      color: getColorButton(),
      disableAnimation: true,
      onTap: () async {
        await prenotaButton();
      },
    );
  }

  Widget _buildButtonPrenota() {
    return Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
            padding: const EdgeInsets.all(20),
            height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.10),
                    spreadRadius: 5,
                    blurRadius: 20)
              ],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Flexible(
                    flex: 600, fit: FlexFit.tight, child: _buildInfoBadge()),
                10.widthBox,
                Flexible(flex: 400, fit: FlexFit.tight, child: _buildButton()),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(backButton: true),
                  20.heightBox,
                  Expanded(
                    child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(
                          dragDevices: {
                            PointerDeviceKind.touch,
                            PointerDeviceKind.mouse,
                          },
                        ),
                        child: SingleChildScrollView(
                            controller: ScrollController(),
                            physics: const BouncingScrollPhysics(),
                            child: SingleChildScrollView(
                                primary: true,
                                physics: const BouncingScrollPhysics(),
                                padding: EdgeInsets.zero,
                                child: Column(children: [
                                  _buildNomeCorso(),
                                  15.heightBox,
                                  _buildStat(
                                      FontAwesomeIcons.calendar,
                                      'Giorno',
                                      corso!.date ?? '',
                                      '#CAE4F9',
                                      '#266DC8',
                                      1),
                                  15.heightBox,
                                  _buildStat(
                                      FontAwesomeIcons.clock,
                                      'Orario',
                                      getStringaOrario(
                                          corso!.hour, corso!.hourStop),
                                      '#E4CCFD',
                                      '#B882D9',
                                      2),
                                  15.heightBox,
                                  _buildStat(
                                      FontAwesomeIcons.home,
                                      'Sala',
                                      corso!.area ?? '',
                                      '#DCFFCE',
                                      '#63B755',
                                      3),
                                  20.heightBox,
                                  _buildPosti(),
                                  110.heightBox,
                                ])))),
                  )
                ],
              ),
            ),
            _buildButtonPrenota().animate(delay: 450.ms).slideY(
                begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo)
          ],
        ));
  }
}
