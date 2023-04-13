import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../controllers/login_controller.dart';
import '../../controllers/menu_controller.dart';

class HeaderWidget extends StatefulWidget {
  bool? backButton;
  HeaderWidget({super.key, this.backButton});

  @override
  HeaderWidgetState createState() => HeaderWidgetState();
}

class HeaderWidgetState extends State<HeaderWidget> {
  LoginController login = Get.find();
  MainMenuController menu = Get.find();

  @override
  void initState() {
    super.initState();
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

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            height: 60,
            width: 100,
            // child: Image.network(
            //   'https://app.edilab.it/ImagesApp/SPORTY/${login.appID!}/logo.png',
            //   fit: BoxFit.contain,
            //   errorBuilder: (context, error, stackTrace) => Container(),
            // ),
            child: FadeInImage.memoryNetwork(
                image:
                    'https://app.edilab.it/ImagesApp/SPORTY/${login.appID!}/logo.png',
                fit: BoxFit.contain,
                imageErrorBuilder: (context, error, stackTrace) => Container(),
                placeholderErrorBuilder: (context, error, stackTrace) =>
                    Container(),
                placeholder: kTransparentImage)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            height: 60,
            left: 0,
            right: 0,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo().animate(delay: 150.ms).fadeIn().scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1, 1),
                      duration: 850.ms,
                      curve: Curves.easeOutExpo)
                ]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (!(widget.backButton ?? false)) {
                      MainMenuController menu = Get.find();
                      menu.toggleMenu();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Icon(
                    (widget.backButton ?? false)
                        ? EvaIcons.arrowBackOutline
                        : EvaIcons.menu,
                    size: 32,
                  ),
                ).animate(delay: 150.ms).fadeIn().slideY(
                    begin: 1,
                    end: 0,
                    duration: 850.ms,
                    curve: Curves.easeOutExpo),
                if (!(widget.backButton ?? false))
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildNotificationIcon()
                              .animate(delay: 150.ms)
                              .fadeIn()
                              .slideY(
                                  begin: 1,
                                  end: 0,
                                  duration: 850.ms,
                                  curve: Curves.easeOutExpo),
                        ]),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
