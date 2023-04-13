import 'dart:convert';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';

class CustomFotoSocioWidget extends StatefulWidget {
  bool? backgroundColor;
  CustomFotoSocioWidget({super.key, this.backgroundColor});

  @override
  State<CustomFotoSocioWidget> createState() => _CustomFotoSocioWidgetState();
}

class _CustomFotoSocioWidgetState extends State<CustomFotoSocioWidget>
    with AutomaticKeepAliveClientMixin {
  SocioController socio = Get.find();

  late Future<String> photo;
  @override
  void initState() {
    super.initState();

    photo = socio.getFotoSocio();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SizedBox(
      width: (widget.backgroundColor ?? false) ? 85 : 70,
      height: (widget.backgroundColor ?? false) ? 85 : 70,
      child: FutureBuilder(
        future: photo,
        builder: (context, snapshot) {
          return Stack(
            children: [
              if (snapshot.connectionState == ConnectionState.waiting)
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    color: Colors.red,
                    width: (widget.backgroundColor ?? false) ? 85 : 70,
                    height: (widget.backgroundColor ?? false) ? 85 : 70,
                  ).applyShimmer(),
                ),
              if (snapshot.connectionState == ConnectionState.done &&
                  ((snapshot.data ?? '').isNotEmpty && snapshot.data != 'NULL'))
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: (widget.backgroundColor ?? false)
                            ? CustomApplication.backgroundColor
                            : Colors.white,
                        child: Image.memory(
                          base64Decode(snapshot.data!),
                          fit: BoxFit.cover,
                          width: (widget.backgroundColor ?? false) ? 85 : 70,
                          height: (widget.backgroundColor ?? false) ? 85 : 70,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(),
              if (snapshot.connectionState == ConnectionState.done &&
                  ((snapshot.data ?? '').isEmpty || snapshot.data == 'NULL'))
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                      width: (widget.backgroundColor ?? false) ? 85 : 70,
                      height: (widget.backgroundColor ?? false) ? 85 : 70,
                      color: (widget.backgroundColor ?? false)
                          ? CustomApplication.backgroundColor
                          : Colors.white.withOpacity(0.5),
                      child: const Icon(EvaIcons.personOutline, size: 36)),
                )
            ],
          );
        },
      ),
    )
        .animate(delay: 150.ms)
        .fadeIn()
        .slideX(begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo);
  }

  @override
  bool get wantKeepAlive => true;
}
