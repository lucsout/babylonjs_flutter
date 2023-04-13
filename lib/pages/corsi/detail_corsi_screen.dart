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
import 'package:sporty/controllers/menu_controller.dart';
import 'package:sporty/models/corso.dart';

import '../../controllers/corsi_controller.dart';
import '../../customs/custom_applications.dart';
import '../../models/news.dart';
import '../../widgets/base/custom_future_builder.dart';
import "package:collection/collection.dart";

import '../../widgets/base/custom_search_widget.dart';
import '../../widgets/base/custom_title_widget.dart';

class DetailCorsiScreen extends StatefulWidget {
  int? idDisciplina;
  String? title;
  DetailCorsiScreen({super.key, this.title, this.idDisciplina});

  @override
  State<DetailCorsiScreen> createState() => _DetailCorsiScreenState();
}

class _DetailCorsiScreenState extends State<DetailCorsiScreen>
    with TickerProviderStateMixin {
  CorsiController corsi = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            EvaIcons.arrowBackOutline,
            size: 32,
          ),
        )
      ],
    );
  }

  Widget _buildCorsoOrario(List<Times> orari, String giorno) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AutoSizeText('📅 $giorno',
              textAlign: TextAlign.start,
              style: GoogleFonts.poppins(
                  height: 1.2,
                  fontWeight: FontWeight.w300,
                  fontSize: 14,
                  color: Colors.black87)),
          5.heightBox,
          ...List.generate(orari.length, (index) {
            return Padding(
                padding: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                child: Text(
                    '🕒 Dalle ${orari[index].hourStart!.substring(0, 5)} alle ${orari[index].hourStop!.substring(0, 5)}'));
          })
        ],
      ),
    );
  }

  Widget _buildSingleDisciplina(Corso corso) {
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
                Expanded(
                  child: AutoSizeText(corso.name!,
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                          height: 1.2,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black87)),
                ),
              ],
            ),
            10.0.heightBox,
            if (corso.mondayTimes != null && corso.mondayTimes!.isNotEmpty)
              _buildCorsoOrario(corso.mondayTimes!, 'Lunedì'),
            if (corso.tuesdayTimes != null && corso.tuesdayTimes!.isNotEmpty)
              _buildCorsoOrario(corso.tuesdayTimes!, 'Martedì'),
            if (corso.wednesdayTimes != null &&
                corso.wednesdayTimes!.isNotEmpty)
              _buildCorsoOrario(corso.wednesdayTimes!, 'Mercoledì'),
            if (corso.thursdayTimes != null && corso.thursdayTimes!.isNotEmpty)
              _buildCorsoOrario(corso.thursdayTimes!, 'Giovedì'),
            if (corso.fridayTimes != null && corso.fridayTimes!.isNotEmpty)
              _buildCorsoOrario(corso.fridayTimes!, 'Venerdì'),
            if (corso.saturdayTimes != null && corso.saturdayTimes!.isNotEmpty)
              _buildCorsoOrario(corso.saturdayTimes!, 'Sabato'),
            if (corso.sundayTimes != null && corso.sundayTimes!.isNotEmpty)
              _buildCorsoOrario(corso.sundayTimes!, 'Domenica')
          ],
        ));
  }

  Widget _buildCorsi() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: FadingEdgeScrollView.fromSingleChildScrollView(
        child: SingleChildScrollView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomFutureBuilder<List<Corso>>(
                  future: corsi.getCorsi(),
                  child: (data) {
                    var corsi = data as List<Corso>;

                    var corsiSingoli = corsi
                        .where((element) =>
                            element.disciplinaID == widget.idDisciplina)
                        .toList();

                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _buildSingleDisciplina(corsiSingoli[index]);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        shrinkWrap: true,
                        itemCount: corsiSingoli.length);
                  }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              _buildHeader(),
              15.heightBox,
              CustomTitleWidget(text: '🏋🏼 ${widget.title!}', delay: 250),
              15.heightBox,
              Expanded(child: _buildCorsi())
            ],
          ),
        ));
  }
}
