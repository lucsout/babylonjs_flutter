import 'dart:math';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty/controllers/centro_controller.dart';
import 'package:sporty/controllers/login_controller.dart';
import 'package:sporty/controllers/socio_controller.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/models/centro_fitness.dart';
import 'package:sporty/widgets/dialogs/dialog_error.dart';

import '../../widgets/base/custom_button_widget.dart';
import '../../widgets/base/custom_dropdown_widget.dart';
import '../../widgets/base/custom_text_form.dart';
import '../../widgets/base/login_background_widget.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with TickerProviderStateMixin {
  int? backgroundIndex;
  bool showCodiceCentro = false;

  CentroFitness? selectedCentroFitness;
  String selectedCentro = '';
  String codiceTessera = '';
  String email = '';

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    backgroundIndex = getBackgroundIndex();

    _controller = AnimationController(vsync: this, duration: 850.ms);
  }

  int getBackgroundIndex() {
    var rng = Random();

    return rng.nextInt(5) + 1;
  }

  Widget _buildLogo() {
    return Image.asset(CustomApplication.assetLogo, fit: BoxFit.cover)
        .animate(delay: 850.ms)
        .fadeIn()
        .scale(
            begin: const Offset(0.8, 0.8),
            end: const Offset(1.0, 1.0),
            curve: Curves.easeOutExpo,
            duration: 2200.ms);
  }

  Future doLogin() async {
    if (selectedCentro == "" || selectedCentroFitness == null) {
      await showDialog(
          context: context,
          builder: (context) =>
              DialogError('Seleziona un centro prima di continuare!'));

      return;
    }

    if (codiceTessera == "") {
      await showDialog(
          context: context,
          builder: (context) => DialogError('Inserisci un codice tessera!'));

      return;
    }

    if (email == "" || !EmailValidator.validate(email)) {
      await showDialog(
          context: context,
          builder: (context) => DialogError('Inserisci una email valida!'));

      return;
    }

    LoginController loginController = Get.find();

    var result = await loginController.loginSocio(
        selectedCentroFitness!.appid!, '1', codiceTessera, email);

    if (!result) {
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (context) =>
                DialogError('Codice tessera e/o email non valida!'));
      }

      return;
    } else {
      SocioController socioController = Get.find();
      await socioController.getInfoSocio();

      Get.offAllNamed('/main');
    }
  }

  Widget _buildFormLogin() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: FadingEdgeScrollView.fromSingleChildScrollView(
        child: SingleChildScrollView(
          controller: ScrollController(),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selezione il tuo centro, inserisci il codice tessera e la tua email',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w100,
                          fontSize: 22,
                          height: 1.1,
                          color: Colors.white))
                  .animate(delay: 650.ms)
                  .fadeIn()
                  .slideY(
                      begin: -1,
                      end: 0,
                      duration: 1280.ms,
                      curve: Curves.fastLinearToSlowEaseIn),
              25.0.heightBox,
              Row(
                children: [
                  Expanded(
                    child: CustomDropdownWidget(
                      value: selectedCentro,
                      hint: 'Seleziona codice centro',
                      onClickCallback: () async {
                        CentroController controller = Get.find();
                        var centri = await controller.getMultiazienda();

                        var list =
                            centri.map((e) => e.nomeCentro ?? '').toList();
                        list.sort((a, b) =>
                            a.toLowerCase().compareTo(b.toLowerCase()));

                        return list;
                      },
                      onCleared: (val) {
                        selectedCentro = "";
                        selectedCentroFitness = null;
                      },
                      onchanged: (val) async {
                        CentroController controller = Get.find();
                        var centri = await controller.getMultiazienda();

                        setState(() {
                          selectedCentro = val!;
                          selectedCentroFitness = centri.firstWhere(
                              (element) => element.nomeCentro == val);
                        });
                      },
                    ),
                  ),
                ],
              ),
              15.0.heightBox,
              CustomTextFormField(
                  text: 'Codice tessera',
                  fontColor: Colors.white,
                  onchanged: (val) => codiceTessera = val),
              15.0.heightBox,
              CustomTextFormField(
                  text: 'Email',
                  fontColor: Colors.white,
                  onchanged: (val) => email = val),
              15.0.heightBox,
              Row(
                children: [
                  Expanded(
                      child: CustomButtonWidget(text: 'Login', onTap: doLogin)),
                ],
              ),
              15.0.heightBox,
              Row(
                children: [
                  Expanded(
                      child: CustomButtonWidget(
                          color: Colors.white,
                          forecolor: Colors.black,
                          text: 'Salta',
                          onTap: () async {
                            if (selectedCentro != "") {
                              LoginController loginController = Get.find();

                              loginController.appID =
                                  selectedCentroFitness!.appid!;

                              loginController.idSede = '1';

                              Get.offAllNamed('/main');
                            } else {
                              await showDialog(
                                  context: context,
                                  builder: (context) => DialogError(
                                      'Seleziona un centro prima di continuare!'));
                            }
                          })),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Inizia subito ad allenarti',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 52,
                      height: 1.1,
                      color: Colors.white))
              .animate(delay: 450.ms)
              .fadeIn()
              .slideY(
                  begin: -1,
                  end: 0,
                  duration: 1280.ms,
                  curve: Curves.fastLinearToSlowEaseIn),
          10.0.heightBox,
          Text('Seleziona il tuo centro ed effettua il login',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w100,
                      fontSize: 22,
                      height: 1.1,
                      color: Colors.white))
              .animate(delay: 650.ms)
              .fadeIn()
              .slideY(
                  begin: -1,
                  end: 0,
                  duration: 1280.ms,
                  curve: Curves.fastLinearToSlowEaseIn),
          25.0.heightBox,
          Row(
            children: [
              Expanded(
                  child: CustomButtonWidget(
                      text: 'Prosegui',
                      onTap: () async {
                        _controller.forward(from: 0);
                      })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Stack(
      children: [
        _buildFormLogin()
            .animate(controller: _controller, autoPlay: false)
            .fadeIn()
            .slideY(
                begin: 1,
                end: 0,
                duration: 850.ms,
                curve: Curves.fastOutSlowIn),
        _buildIntroText()
            .animate(controller: _controller, autoPlay: false)
            .fadeOut()
            .slideY(
                begin: 0,
                end: -1,
                duration: 850.ms,
                curve: Curves.fastOutSlowIn),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
            child: ClipRect(
                child: LoginBackground(backgroundAsset: backgroundIndex))),
        Positioned.fill(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            25.heightBox,
            Flexible(flex: 150, child: _buildLogo()),
            10.heightBox,
            Expanded(flex: 250, child: _buildForm()),
            30.heightBox,
          ],
        )),
      ],
    ));
  }
}
