import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sporty/controllers/corsi_controller.dart';
import 'package:sporty/controllers/gallery_controller.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/models/prenotazione.dart';
import 'package:sporty/widgets/base/custom_future_builder.dart';
import 'package:sporty/widgets/base/custom_header_widget.dart';
import 'package:sporty/widgets/dialogs/dialog_loading.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controllers/socio_controller.dart';
import '../../models/corso.dart';
import '../../models/gallery.dart';
import '../../widgets/base/custom_title_widget.dart';

class LeMiePrenotazioniScreen extends StatefulWidget {
  const LeMiePrenotazioniScreen({super.key});

  @override
  State<LeMiePrenotazioniScreen> createState() =>
      _LeMiePrenotazioniScreenState();
}

class _LeMiePrenotazioniScreenState extends State<LeMiePrenotazioniScreen>
    with TickerProviderStateMixin {
  SocioController socio = Get.find();
  CorsiController corsi = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildEmptyPrenotazioni() {
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
                    child: AutoSizeText('Nessuna prenotazione effettuata',
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

  Widget _buildBadge(String stato, String color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: color == '#2ecc71' ? Colors.green : HexColor(color),
          borderRadius: BorderRadius.circular(10)),
      child: AutoSizeText(stato == ' - ' ? 'IN CORSO' : stato,
          maxLines: 1,
          minFontSize: 4,
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400, fontSize: 12, color: Colors.white)),
    );
  }

  Color getColorBackgroundPrenotazione(Prenotazione preno) {
    return CustomApplication.backgroundColor;

    // switch (preno.stato) {
    //   case 'ANNULLATO':
    //     return HexColor(preno.color ?? '#ffffff');
    //   default:
    //     return CustomApplication.backgroundColor;
    // }
  }

  Color getColorForegroundPrenotazione(Prenotazione preno) {
    return Colors.black;

    // switch (preno.stato) {
    //   case 'ANNULLATO':
    //     return Colors.white;
    //   default:
    //     return Colors.black;
    // }
  }

  Widget _buildSinglePrenotazione(Prenotazione preno) {
    return GestureDetector(
      onTap: () async {
        SmartDialog.showLoading(msg: 'Caricamento...');

        var book = await corsi.getSingleCorso(preno.iD!);

        SmartDialog.dismiss();

        await Get.toNamed('/corsodetail', arguments: book);

        setState(() {});
      },
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: getColorBackgroundPrenotazione(preno),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 35,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText('🏋️',
                          maxLines: 1,
                          minFontSize: 12,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black)),
                      5.heightBox,
                      AutoSizeText('📅',
                          maxLines: 1,
                          minFontSize: 12,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black)),
                      5.heightBox,
                      AutoSizeText('🕒',
                          maxLines: 1,
                          minFontSize: 12,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black)),
                      5.heightBox,
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AutoSizeText(preno.corso ?? '',
                              maxLines: 2,
                              minFontSize: 12,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color:
                                      getColorForegroundPrenotazione(preno))),
                        ),
                      ],
                    ),
                    5.heightBox,
                    AutoSizeText(
                        (preno.data ?? '')
                            .replaceAll(preno.orario ?? '', '')
                            .toUpperCase(),
                        maxLines: 1,
                        minFontSize: 12,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: getColorForegroundPrenotazione(preno))),
                    5.heightBox,
                    AutoSizeText(
                        'Dalle ${(preno.orario ?? '').toUpperCase().replaceAll(' - ', ' alle ')}',
                        maxLines: 1,
                        minFontSize: 12,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: getColorForegroundPrenotazione(preno))),
                    5.heightBox,
                    _buildBadge(preno.stato ?? '', preno.color ?? '#ffffff')
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildListaPrenotazioni(List<Prenotazione> data) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildSinglePrenotazione((data)[index])
              .animate(delay: (65 * index).ms)
              .fadeIn(curve: Curves.easeOutExpo)
              .slideY(
                  begin: 0.5,
                  end: 0,
                  duration: 850.ms,
                  curve: Curves.easeOutExpo);
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        shrinkWrap: true,
        itemCount: data.length);
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
            Expanded(
              child: CustomFutureBuilder<List<Prenotazione>>(
                  future: socio.getPrenotazioniSocio(),
                  child: (data) {
                    return SizedBox.expand(
                        child: ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                      ),
                      child: SmartRefresher(
                        controller: RefreshController(),
                        enablePullDown: true,
                        header: WaterDropHeader(
                            waterDropColor: CustomApplication.accentColor),
                        onRefresh: () {
                          setState(() {});
                        },
                        primary: true,
                        physics: const BouncingScrollPhysics(),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(25),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  10.heightBox,
                                  CustomTitleWidget(
                                      text: '📆 Le mie prenotazioni',
                                      delay: 100,
                                      padding: false),
                                  10.heightBox,
                                  ((data as List<Prenotazione>)).isNotEmpty
                                      ? _buildListaPrenotazioni(
                                          (data as List<Prenotazione>))
                                      : _buildEmptyPrenotazioni()
                                ]),
                          ),
                        ),
                      ),
                    ));
                  }),
            ),
          ],
        ));
  }
}
