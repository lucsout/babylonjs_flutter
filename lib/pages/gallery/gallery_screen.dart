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
import 'package:sporty/controllers/gallery_controller.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/widgets/base/custom_future_builder.dart';
import 'package:sporty/widgets/base/custom_header_widget.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/gallery.dart';
import '../../widgets/base/custom_title_widget.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>
    with TickerProviderStateMixin {
  GalleryController gallery = Get.find();

  @override
  void initState() {
    super.initState();
  }

  Widget _buildImages(Gallery gallery) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
      ),
      child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SizedBox(
              width: Get.width * 0.80,
              child: Padding(
                padding: EdgeInsets.fromLTRB(index == 0 ? 25 : 0, 0,
                    index == (gallery.galleryPictures! - 1) ? 25 : 0, 0),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                              color: Colors.red,
                              width: Get.width * 0.80,
                              height: Get.height * 0.35)
                          .applyShimmer(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/photo',
                            arguments: gallery.galleryUrls![index]);
                      },
                      child: Hero(
                        tag: gallery.galleryUrls![index],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: FadeInImage.memoryNetwork(
                              image: gallery.galleryUrls![index],
                              fit: BoxFit.cover,
                              width: Get.width * 0.80,
                              height: Get.height * 0.35,
                              placeholder: kTransparentImage),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ).animate(delay: (index * 60).ms).fadeIn().slideX(
                begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
          },
          separatorBuilder: (context, index) =>
              const SizedBox(height: 15, width: 15),
          itemCount: gallery.galleryPictures!),
    );
  }

  Widget _buildInfoCentro(Gallery gallery) {
    return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: CustomApplication.backgroundColor),
            child: Text(gallery.galleryDescription ?? '',
                textAlign: TextAlign.start,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                    color: Colors.black)))
        .animate(delay: 220.ms)
        .fadeIn()
        .slideY(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
  }

  Widget _buildIconContatto(
      IconData icon, String contatto, String tipo, bool isSocial, int index) {
    return GestureDetector(
      onTap: () {
        switch (tipo) {
          case 'Whatsapp':
            launchUrl(Uri.parse('https://wa.me/$contatto'));
            break;
          case 'Telefono':
            launchUrl(Uri.parse('tel://$contatto'));
            break;
          case 'Instagram':
            launchUrl(Uri.parse(contatto));
            break;
          case 'Facebook':
            launchUrl(Uri.parse(contatto));
            break;
          case 'Email':
            launchUrl(Uri.parse('mailto://$contatto'));
            break;
          case 'Sito':
            launchUrl(Uri.parse(contatto));
            break;
          case 'TikTok':
            launchUrl(Uri.parse(contatto));
            break;
        }
      },
      child: Container(
              height: 70,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.04),
                        blurRadius: 15,
                        spreadRadius: 5)
                  ],
                  borderRadius: BorderRadius.circular(8),
                  color: CustomApplication.backgroundColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  8.heightBox,
                  Icon(icon, color: Colors.black87),
                  5.heightBox,
                  Expanded(
                      child: AutoSizeText(tipo,
                          maxLines: 1,
                          minFontSize: 4,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w300,
                              fontSize: 12,
                              color: Colors.black))),
                  5.heightBox,
                ],
              ))
          .animate(delay: (index * 60).ms)
          .fadeIn()
          .slideX(
              begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo),
    );
  }

  Widget _buildIndirizzo(Gallery gallery) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          color: CustomApplication.backgroundColor),
      child: Row(
        children: [
          Container(
              width: 60,
              height: 60,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: CustomApplication.backgroundColor,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12.withOpacity(0.06),
                      blurRadius: 15,
                      spreadRadius: 5)
                ],
              ),
              child: const Icon(FontAwesomeIcons.locationDot,
                  size: 28, color: Colors.red)),
          25.widthBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText('Ci troviamo qui:',
                    maxLines: 1,
                    minFontSize: 4,
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Colors.black)),
                5.heightBox,
                Expanded(
                  child: AutoSizeText('🏚️ ${gallery.galleryIndirizzo ?? ''}',
                      maxLines: 2,
                      minFontSize: 12,
                      textAlign: TextAlign.start,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate(delay: 180.ms)
        .fadeIn()
        .slideY(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
  }

  Widget _buildContattiCard(Gallery gallery) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: CustomApplication.backgroundColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          4.heightBox,
          Row(children: [
            if (gallery.galleryTelefono != null &&
                gallery.galleryTelefono!.isNotEmpty)
              Flexible(
                fit: FlexFit.tight,
                child: _buildIconContatto(EvaIcons.phoneOutline,
                    gallery.galleryTelefono ?? '', 'Telefono', false, 1),
              ),
            if (gallery.galleryWhatsapp != null &&
                gallery.galleryWhatsapp!.isNotEmpty)
              Flexible(
                fit: FlexFit.tight,
                child: _buildIconContatto(FontAwesomeIcons.whatsapp,
                    gallery.galleryWhatsapp ?? '', 'Whatsapp', false, 2),
              ),
            if (gallery.galleryEmail != null &&
                gallery.galleryEmail!.isNotEmpty)
              Flexible(
                  fit: FlexFit.tight,
                  child: _buildIconContatto(EvaIcons.atOutline,
                      gallery.galleryEmail ?? '', 'Email', false, 3)),
            if (gallery.gallerySito != null && gallery.gallerySito!.isNotEmpty)
              Flexible(
                  fit: FlexFit.tight,
                  child: _buildIconContatto(EvaIcons.globe,
                      gallery.gallerySito ?? '', 'Sito', false, 4)),
          ]),
          Row(
            children: [
              if (gallery.galleryFacebook != null &&
                  gallery.galleryFacebook!.isNotEmpty)
                Flexible(
                    fit: FlexFit.tight,
                    child: _buildIconContatto(FontAwesomeIcons.facebook,
                        gallery.galleryFacebook ?? '', 'Facebook', true, 5)),
              if (gallery.galleryInstagram != null &&
                  gallery.galleryInstagram!.isNotEmpty)
                Flexible(
                  fit: FlexFit.tight,
                  child: _buildIconContatto(
                      FontAwesomeIcons.instagram, '', 'Instagram', true, 6),
                ),
              if (gallery.galleryTikTok != null &&
                  gallery.galleryTikTok!.isNotEmpty)
                Flexible(
                    fit: FlexFit.tight,
                    child: _buildIconContatto(
                        FontAwesomeIcons.tiktok, '', 'TikTok', true, 7)),
            ],
          ),
        ],
      ),
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
            Expanded(
              child: CustomFutureBuilder<Gallery?>(
                  future: gallery.getGalleryInfo(),
                  child: (gallery) {
                    return SizedBox.expand(
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
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomTitleWidget(
                                        text: '🖼️ Gallery',
                                        delay: 100,
                                        padding: true),
                                    10.heightBox,
                                    SizedBox(
                                        height: Get.height * 0.35,
                                        child:
                                            _buildImages(gallery as Gallery)),
                                    10.heightBox,
                                    CustomTitleWidget(
                                        text: '📝 Contatti e social',
                                        delay: 175,
                                        padding: true),
                                    10.heightBox,
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 0, 25, 0),
                                      child: _buildContattiCard(gallery),
                                    ),
                                    10.heightBox,
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          25, 0, 25, 0),
                                      child: _buildIndirizzo(gallery),
                                    ),
                                    10.heightBox,
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              25, 0, 25, 0),
                                          child: _buildInfoCentro(gallery),
                                        ),
                                      ],
                                    ),
                                    15.heightBox,
                                  ]),
                            ),
                          )),
                    );
                  }),
            ),
          ],
        ));
  }
}
