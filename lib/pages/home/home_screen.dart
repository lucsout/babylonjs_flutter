import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sporty/controllers/login_controller.dart';
import 'package:sporty/controllers/menu_controller.dart';
import 'package:sporty/controllers/news_controller.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/widgets/base/custom_future_builder.dart';
import 'package:sporty/widgets/base/custom_header_widget.dart';
import 'package:sporty/widgets/base/custom_title_widget.dart';

import '../../models/news.dart';
import '../../widgets/base/custom_hand_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MainMenuController menu = Get.find();
  SocioController socio = Get.find();
  NewsController news = Get.find();
  LoginController login = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildHeaderSocio() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(
            flex: 400,
            fit: FlexFit.tight,
            child: ClipRect(
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
                            fontSize: 24,
                            color: Colors.black)),
                  if (socio.socio == null)
                    Text('Effettua il login',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Colors.black)),
                ],
              ).animate(delay: 150.ms).fadeIn().slideY(
                  begin: 1,
                  end: 0,
                  duration: 850.ms,
                  curve: Curves.easeOutExpo),
            ),
          ),
          if (socio.socio != null)
            Flexible(
              flex: 400,
              fit: FlexFit.tight,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                _buildQRCode(),
              ]),
            )
        ]);
  }

  Widget _buildQRCode() {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/qr');
      },
      child: ClipRRect(
        child: QrImage(
          data: socio.socio!.codTessera!,
          version: QrVersions.auto,
          size: 110.0,
        ).animate(delay: 250.ms).fadeIn().scale(
            begin: const Offset(0.50, 0.50),
            end: const Offset(1, 1),
            duration: 850.ms,
            curve: Curves.easeOutExpo),
      ),
    );
  }

  Widget _buildNews() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTitleWidget(text: '📰 Bacheca', delay: 250),
        10.heightBox,
        _buildBachecaList()
      ],
    );
  }

  Widget _buildSingleNews(News news) {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomApplication.backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                if (news.image != null && news.image != "")
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(base64Decode(news.image!),
                          fit: BoxFit.cover, width: 60, height: 60)),
                if (news.image != null && news.image != "") 10.0.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (DateFormat('dd/MM/yyyy').format(news.data!) !=
                          '01/01/1900')
                        AutoSizeText(
                            DateFormat('dd/MM/yyyy').format(news.data!),
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                height: 1.2,
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.black87)),
                      if (DateFormat('dd/MM/yyyy').format(news.data!) !=
                          '01/01/1900')
                        5.heightBox,
                      AutoSizeText(news.titolo!,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              height: 1.2,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black87)),
                    ],
                  ),
                ),
              ],
            ),
            10.heightBox,
            Text(news.testo!,
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black87)),
          ],
        ));
  }

  Widget _buildBachecaList() {
    return CustomFutureBuilder<List<News>>(
        future: news.getNews(),
        child: (data) {
          return ((data as List<News>)).isNotEmpty
              ? ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildSingleNews((data)[index])
                        .animate(delay: (65 * index).ms)
                        .fadeIn(curve: Curves.easeOutExpo)
                        .slideY(
                            begin: 0.5,
                            end: 0,
                            duration: 850.ms,
                            curve: Curves.easeOutExpo);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  itemCount: ((data as List<News>)).length)
              : _buildEmptyNews();
        });
  }

  Widget _buildEmptyNews() {
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: CustomApplication.backgroundColor),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: AutoSizeText('Nessun messaggio in bacheca',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            height: 1.2,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black87)),
                  )
                ],
              )
            ]));
  }

  Widget _buildLine() {
    return Container(height: 1, color: Colors.black26)
        .animate(delay: 200.ms)
        .fadeIn()
        .slideY(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(children: [
                HeaderWidget(),
                15.heightBox,
                _buildHeaderSocio(),
                15.heightBox,
                _buildLine(),
                15.heightBox,
                Expanded(
                    child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: FadingEdgeScrollView.fromSingleChildScrollView(
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          controller: ScrollController(),
                          child: Column(children: [_buildNews()]))),
                ))
              ])),
        ));
  }
}
