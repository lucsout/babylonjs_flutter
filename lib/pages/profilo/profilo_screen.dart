import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sporty/controllers/gallery_controller.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/widgets/base/custom_future_builder.dart';
import 'package:sporty/widgets/base/custom_header_widget.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/gallery.dart';
import '../../models/socio.dart';
import '../../widgets/base/custom_foto_widget.dart';
import '../../widgets/base/custom_title_widget.dart';

class ProfiloScreen extends StatefulWidget {
  const ProfiloScreen({super.key});

  @override
  State<ProfiloScreen> createState() => _ProfiloScreenState();
}

class _ProfiloScreenState extends State<ProfiloScreen>
    with TickerProviderStateMixin {
  SocioController socio = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildCardPhoto() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomFotoSocioWidget(backgroundColor: true),
        25.widthBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AutoSizeText(socio.socio!.nominativo!,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      height: 1.2,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.black87)),
              5.heightBox,
              AutoSizeText(socio.socio!.email ?? '',
                  maxLines: 1,
                  style: GoogleFonts.poppins(
                      height: 1.2,
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.black87)),
            ],
          ).animate(delay: 150.ms).fadeIn().slideY(
              begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo),
        ),
      ],
    );
  }

  Widget _buildIconSocio(String emoji, String desc, String data, int index) {
    // return Container(
    //         height: 120,
    //         margin: const EdgeInsets.all(5),
    //         padding: const EdgeInsets.all(12),
    //         decoration: BoxDecoration(
    //             shape: BoxShape.rectangle,
    //             boxShadow: [
    //               BoxShadow(
    //                   color: Colors.black12.withOpacity(0.06),
    //                   blurRadius: 15,
    //                   spreadRadius: 5)
    //             ],
    //             borderRadius: BorderRadius.circular(15),
    //             color: CustomApplication.backgroundColor),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             AutoSizeText(emoji,
    //                 maxLines: 1,
    //                 minFontSize: 4,
    //                 textAlign: TextAlign.start,
    //                 style: GoogleFonts.poppins(
    //                     fontWeight: FontWeight.w300,
    //                     fontSize: 18,
    //                     color: Colors.black)),
    //             5.heightBox,
    //             AutoSizeText(desc,
    //                 maxLines: 1,
    //                 minFontSize: 4,
    //                 textAlign: TextAlign.start,
    //                 style: GoogleFonts.poppins(
    //                     fontWeight: FontWeight.w300,
    //                     fontSize: 12,
    //                     color: Colors.black)),
    //             Expanded(
    //                 child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 AutoSizeText(data,
    //                     maxLines: 1,
    //                     minFontSize: 4,
    //                     textAlign: TextAlign.start,
    //                     style: GoogleFonts.poppins(
    //                         fontWeight: FontWeight.bold,
    //                         fontSize: 18,
    //                         color: Colors.black87)),
    //               ],
    //             )),
    //           ],
    //         ))
    //     .animate(delay: (index * 60).ms)
    //     .fadeIn()
    //     .slideX(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);

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
                AutoSizeText(emoji,
                    maxLines: 1,
                    minFontSize: 4,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                        color: Colors.black)),
                AutoSizeText(data,
                    maxLines: 1,
                    minFontSize: 4,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
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
                            fontSize: 12,
                            color: Colors.black)),
                  ],
                ),
              ],
            ))
        .animate(delay: (index * 60).ms)
        .fadeIn()
        .slideX(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
  }

  Widget _buildContattiCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Flexible(
            fit: FlexFit.tight,
            child: _buildIconSocio(
                '💳', 'Tessera n°', socio.socio!.badge ?? '', 1),
          ),
          10.widthBox,
          Flexible(
            fit: FlexFit.tight,
            child: _buildIconSocio('🩺', 'Certificato',
                socio.socio!.certificato!.substring(0, 10) ?? '', 2),
          ),
          10.widthBox,
          Flexible(
              fit: FlexFit.tight,
              child: _buildIconSocio(
                  '🏆', 'Punti fidelity', socio.socio!.punti ?? '', 5)),
        ]),
      ],
    );
  }

  Widget _buildBadge(bool scaduto) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: socio.socio!.affScaduta ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(10)),
      child: AutoSizeText(socio.socio!.affScaduta ? 'Scaduta' : 'Valida',
          maxLines: 1,
          minFontSize: 4,
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white)),
    );
  }

  Widget _buildAffiliazione() {
    return Container(
            height: 120,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                color: CustomApplication.backgroundColor),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Container(
                      width: 60,
                      height: 60,
                      padding: const EdgeInsets.all(15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CustomApplication.backgroundColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.06),
                              blurRadius: 15,
                              spreadRadius: 5)
                        ],
                      ),
                      child: Icon(
                          socio.socio!.affScaduta
                              ? FontAwesomeIcons.warning
                              : FontAwesomeIcons.medal,
                          size: 32,
                          color: socio.socio!.affScaduta
                              ? Colors.redAccent
                              : Colors.green)),
                  15.widthBox,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText('Scadenza affiliazione',
                            maxLines: 1,
                            minFontSize: 4,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.black)),
                        5.heightBox,
                        Expanded(
                            child: AutoSizeText(socio.socio!.scadenzaAff ?? '',
                                maxLines: 1,
                                minFontSize: 12,
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black))),
                        _buildBadge(socio.socio!.affScaduta),
                      ],
                    ),
                  ),
                ],
              ),
            ))
        .animate(delay: 180.ms)
        .fadeIn()
        .slideY(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
  }

  Widget _buildSingleContratto(Contratto contratti, int index) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: CustomApplication.backgroundColor,
            borderRadius: BorderRadius.circular(20)),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AutoSizeText(contratti.descContratto ?? '',
                      maxLines: 1,
                      minFontSize: 12,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black)),
                  10.widthBox,
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                    child: const Icon(FontAwesomeIcons.check,
                        color: Colors.white, size: 10),
                  )
                ],
              ),
              5.heightBox,
              AutoSizeText(
                  '${contratti.dataInizio!.substring(0, 10)} - ${contratti.dataTermine!.substring(0, 10)}',
                  maxLines: 1,
                  minFontSize: 12,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                      color: Colors.black)),
              5.heightBox,
              if (contratti.ingressiSettimana != "NULL" &&
                  contratti.ingressiSettimana != "0")
                AutoSizeText(
                    'Ingressi a settimana: ${contratti.ingressiSettimana}',
                    maxLines: 1,
                    minFontSize: 12,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black)),
              if (contratti.ingressiSettimana != "NULL" &&
                  contratti.ingressiSettimana != "0")
                5.heightBox,
              if (contratti.numSeduteContratto != "NULL" &&
                  contratti.numSeduteContratto != "0")
                AutoSizeText('Sedute residue: ${contratti.numSeduteContratto}',
                    maxLines: 1,
                    minFontSize: 12,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black)),
              if (contratti.numSeduteContratto != "NULL" &&
                  contratti.numSeduteContratto != "0")
                5.heightBox,
            ],
          )
        ]));
  }

  Widget _buildContratti() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildSingleContratto(
                      socio.socio!.contratto![index], index);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: (socio.socio!.contratto ?? []).length)
            .animate(delay: 250.ms)
            .fadeIn()
            .slideY(
                begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo),
        10.heightBox,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: HeaderWidget(),
            ),
            10.heightBox,
            Expanded(
                child: SizedBox.expand(
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
                              child: Padding(
                                padding: const EdgeInsets.all(30),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      _buildCardPhoto(),
                                      15.heightBox,
                                      _buildContattiCard(),
                                      10.heightBox,
                                      if (!socio.socio!.hideAff)
                                        _buildAffiliazione(),
                                      if (!socio.socio!.hideAff) 10.heightBox,
                                      CustomTitleWidget(
                                          text: '📄 I miei contratti',
                                          delay: 250,
                                          padding: false),
                                      10.heightBox,
                                      _buildContratti(),
                                    ]),
                              ),
                            ))))),
          ],
        ));
  }
}
