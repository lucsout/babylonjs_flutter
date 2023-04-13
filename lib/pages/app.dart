import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/pages/gallery/gallery_photo_screen.dart';
import 'package:sporty/pages/login/intro_screen.dart';
import 'package:sporty/pages/prenotazioni/single_corso_detail_screen.dart';
import 'package:sporty/pages/profilo/profilo_screen.dart';
import 'package:sporty/pages/qrcode/qr_screen.dart';
import 'package:sporty/widgets/dialogs/dialog_loading.dart';

import '../widgets/customs/custom_page_transition.dart';
import 'main_screen.dart';
import 'splash_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(name: '/', page: () => SplashScreen()),
        GetPage(name: '/intro', page: () => const IntroScreen()),
        GetPage(name: '/main', page: () => const MainScreen()),
        GetPage(name: '/qr', page: () => const QrScreen()),
        GetPage(name: '/corsodetail', page: () => SingleCorsoDetailScreen()),
        GetPage(name: '/photo', page: () => const GalleryPhotoScreen()),
      ],
      transitionDuration: 850.ms,
      customTransition: CustomSportyTransition(),
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(
        loadingBuilder: (String msg) => DialogLoading(title: msg),
      ),
      home: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: CustomApplication.name,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
