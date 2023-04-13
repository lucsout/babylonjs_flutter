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
import 'package:sporty/pages/corsi/detail_corsi_screen.dart';
import 'package:sporty/widgets/base/custom_header_widget.dart';

import '../../controllers/corsi_controller.dart';
import '../../customs/custom_applications.dart';
import '../../models/news.dart';
import '../../widgets/base/custom_future_builder.dart';
import "package:collection/collection.dart";

import '../../widgets/base/custom_search_widget.dart';
import '../../widgets/base/custom_title_widget.dart';

class CorsiScreen extends StatefulWidget {
  const CorsiScreen({super.key});

  @override
  State<CorsiScreen> createState() => _CorsiScreenState();
}

class _CorsiScreenState extends State<CorsiScreen>
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
                    '🕒 Dalle ${orari[index].hourStart!.substring(0, 5)} alle ${orari[index].hourStop!.substring(0, 5)} - ${orari[index].structure!}'));
          })
        ],
      ),
    );
  }

  Widget _buildSingleCorso(Corso corso) {
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
            5.heightBox,
            // Row(
            //   children: [
            //     Expanded(
            //       child: AutoSizeText('Gruppo: ${corso.disciplina!}',
            //           textAlign: TextAlign.start,
            //           maxLines: 2,
            //           style: GoogleFonts.poppins(
            //               height: 1.2,
            //               fontWeight: FontWeight.w300,
            //               fontSize: 14,
            //               color: Colors.black87)),
            //     ),
            //   ],
            // ),
            // 5.heightBox,
            Row(
              children: [
                Expanded(
                  child: AutoSizeText('Disciplina: ${corso.disciplina!}',
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      style: GoogleFonts.poppins(
                          height: 1.2,
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black87)),
                ),
              ],
            ),
            15.0.heightBox,
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

  Widget _buildSingleDisciplina(Corso corso, int totalCorsi) {
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(corso.disciplina!,
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
            10.0.heightBox,
            AutoSizeText(
                totalCorsi == 1
                    ? '1 corso per questa disciplina'
                    : '$totalCorsi corsi per questa disciplina',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    height: 1.2,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black87)),
          ],
        ));
  }

  Widget _buildDiscipline() {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: FadingEdgeScrollView.fromSingleChildScrollView(
        child: SingleChildScrollView(
          controller: scroll,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              10.heightBox,
              CustomFutureBuilder<List<Corso>>(
                  future: corsiFuture,
                  child: (data) {
                    corsiLoaded = data as List<Corso>;

                    var countDiscipline = corsiLoaded
                        .groupListsBy((element) => element.disciplinaID);

                    var intDiscipline = corsiLoaded
                        .groupListsBy((element) => element.disciplinaID)
                        .keys
                        .toList();

                    List<Corso> discipline = [];

                    for (int? idDisciplina in intDiscipline) {
                      discipline.add(corsiLoaded.firstWhere(
                          (element) => element.disciplinaID == idDisciplina));
                    }

                    discipline.sort((a, b) => a.disciplina!
                        .toLowerCase()
                        .compareTo(b.disciplina!.toLowerCase()));

                    return ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                      elevation: 0,
                                      contentPadding: EdgeInsets.zero,
                                      backgroundColor: Colors.transparent,
                                      content: DetailCorsiScreen(
                                          title: discipline[index].disciplina,
                                          idDisciplina:
                                              discipline[index].disciplinaID)));
                            },
                            child: _buildSingleDisciplina(
                                discipline[index],
                                countDiscipline[discipline[index].disciplinaID]!
                                    .length),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        shrinkWrap: true,
                        itemCount: discipline.length);
                  }),
              10.heightBox,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilteredDiscipline() {
    var corsiSingoli = corsiLoaded
        .where((element) =>
            element.disciplina!
                .toLowerCase()
                .contains(isFiltering.value.toLowerCase()) ||
            element.grpDisciplina!
                .toLowerCase()
                .contains(isFiltering.value.toLowerCase()) ||
            element.name!
                .toLowerCase()
                .contains(isFiltering.value.toLowerCase()))
        .toList();

    return FadingEdgeScrollView.fromSingleChildScrollView(
      child: SingleChildScrollView(
        controller: scroll,
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            10.heightBox,
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildSingleCorso(corsiSingoli[index]);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                shrinkWrap: true,
                itemCount: corsiSingoli.length),
            10.heightBox,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              HeaderWidget(),
              15.heightBox,
              CustomTitleWidget(text: '🤸🏼 Discipline', delay: 250),
              15.heightBox,
              SearchWidget(
                text: 'Ricerca corso',
                onSearched: (val) async {
                  isFiltering.value = val;

                  Future.delayed(250.ms, () {
                    scroll.animateTo(0,
                        duration: 850.ms, curve: Curves.fastOutSlowIn);
                  });
                },
              ).animate().fadeIn().slideY(
                  begin: 1,
                  end: 0,
                  duration: 850.ms,
                  curve: Curves.easeOutExpo),
              10.heightBox,
              Expanded(
                  child: Obx(() => isFiltering.value.isEmpty
                      ? _buildDiscipline()
                      : _buildFilteredDiscipline()))
            ],
          ),
        ));
  }
}
