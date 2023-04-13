import 'dart:math';
import 'dart:ui';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sporty/controllers/menu_controller.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:transparent_image/transparent_image.dart';

class GalleryPhotoScreen extends StatefulWidget {
  const GalleryPhotoScreen({super.key});

  @override
  State<GalleryPhotoScreen> createState() => _GalleryPhotoScreenState();
}

class _GalleryPhotoScreenState extends State<GalleryPhotoScreen>
    with TickerProviderStateMixin {
  String urlPhoto = '';

  final PhotoViewScaleStateController _controller =
      PhotoViewScaleStateController();

  final PhotoViewScaleStateController _controllerHero =
      PhotoViewScaleStateController();
  @override
  void initState() {
    super.initState();

    urlPhoto = Get.arguments.toString();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () async {
            _controller.scaleState = PhotoViewScaleState.initial;

            await Future.delayed(200.ms);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Hero(
                          tag: urlPhoto,
                          flightShuttleBuilder: (
                            BuildContext flightContext,
                            Animation<double> animation,
                            HeroFlightDirection flightDirection,
                            BuildContext fromHeroContext,
                            BuildContext toHeroContext,
                          ) {
                            return AnimatedBuilder(
                                animation: animation,
                                builder: (context, value) {
                                  return SizedBox(
                                    width: lerpDouble(Get.width * 0.80,
                                        Get.width * 0.95, animation.value),
                                    height: lerpDouble(Get.height * 0.35,
                                        Get.height * 0.85, animation.value),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: PhotoView(
                                          scaleStateController: _controllerHero,
                                          initialScale:
                                              PhotoViewComputedScale.covered,
                                          backgroundDecoration:
                                              const BoxDecoration(
                                                  color: Colors.transparent),
                                          imageProvider: NetworkImage(
                                            urlPhoto,
                                          )),
                                    ),
                                  );
                                });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              width: Get.width * 0.95,
                              height: Get.height * 0.85,
                              child: PhotoView(
                                  initialScale: PhotoViewComputedScale.covered,
                                  scaleStateController: _controller,
                                  backgroundDecoration: const BoxDecoration(
                                      color: Colors.transparent),
                                  imageProvider: NetworkImage(
                                    urlPhoto,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
