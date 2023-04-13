import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sporty/controllers/centro_controller.dart';
import 'package:sporty/controllers/corsi_controller.dart';
import 'package:sporty/controllers/gallery_controller.dart';
import 'package:sporty/controllers/login_controller.dart';
import 'package:sporty/controllers/menu_controller.dart';
import 'package:sporty/controllers/news_controller.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/pages/login/intro_screen.dart';
import 'package:sporty/widgets/customs/custom_page_transition.dart';

import '../widgets/base/loading_widget.dart';

class SplashScreen extends StatefulWidget {
  bool? noInit;

  SplashScreen({super.key, this.noInit});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future? initFuture;

  final List assetsToPreload = [
    'assets/images/backgrounds/BACKGROUND_1.jpg',
    'assets/images/backgrounds/BACKGROUND_2.jpg',
    'assets/images/backgrounds/BACKGROUND_3.jpg',
    'assets/images/backgrounds/BACKGROUND_4.jpg',
    'assets/images/backgrounds/BACKGROUND_5.jpg',
    'assets/images/backgrounds/BACKGROUND_6.jpg',
  ];

  @override
  void initState() {
    super.initState();

    Get.put(CentroController());
    Get.put(LoginController());
    Get.put(MainMenuController());
    Get.put(SocioController());
    Get.put(NewsController());
    Get.put(CorsiController());
    Get.put(GalleryController());

    if (widget.noInit == null || !(widget.noInit!)) {
      initFuture = init();
    }
  }

  Future init() async {
    final binding = WidgetsFlutterBinding.ensureInitialized();
    binding.addPostFrameCallback((_) async {
      //Preload degli assets in memoria
      for (var asset in assetsToPreload) {
        await precacheImage(AssetImage(asset), context);
      }
    });

    await initializeDateFormatting();

    await Future.delayed(850.ms);

    LoginController login = Get.find();
    await login.loadData();

    if (login.tokenID != null && login.tokenID!.isNotEmpty) {
      SocioController socioController = Get.find();
      await socioController.getInfoSocio();

      Get.offAllNamed('/main');
    } else {
      Get.offAllNamed('/intro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: initFuture,
      builder: (_, data) {
        return LoadingWidget(text: 'Caricamento');
      },
    ));
  }
}
