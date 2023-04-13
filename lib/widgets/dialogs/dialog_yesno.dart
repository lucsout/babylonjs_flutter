import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../customs/custom_applications.dart';

class DialogYesNo extends StatefulWidget {
  String? text;
  Function? onYes;
  Function? onNo;

  DialogYesNo({this.text, this.onYes, this.onNo});

  @override
  _DialogYesNoState createState() => _DialogYesNoState();
}

class _DialogYesNoState extends State<DialogYesNo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).scaffoldBackgroundColor),
            child: Column(children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: Container(
                    height: 80,
                    color: CustomApplication.accentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.clipboardQuestion,
                                size: 38, color: Colors.white)
                            .animate(delay: 250.ms)
                            .rotate(
                                begin: 0,
                                end: 1,
                                curve: Curves.easeOutExpo,
                                duration: 1050.ms)
                            .scale(
                                begin: const Offset(0, 0),
                                end: const Offset(1.2, 1.2),
                                curve: Curves.easeOutExpo,
                                duration: 850.ms)
                            .scale(
                                begin: const Offset(1.2, 1.2),
                                end: const Offset(1, 1),
                                curve: Curves.easeOutExpo,
                                delay: 285.ms,
                                duration: 850.ms),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.text ?? '',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (widget.onNo != null) await widget.onNo!();

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(25)),
                      child: const Center(
                        child: Text('Annulla',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w400,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                  10.widthBox,
                  SizedBox(
                    height: 50,
                    width: 110,
                    child: RoundedLoadingButton(
                        controller: RoundedLoadingButtonController(),
                        onPressed: () async {
                          await widget.onYes!();
                          Navigator.pop(context);
                        },
                        color: CustomApplication.accentColor,
                        borderRadius: 25,
                        child: const Center(
                            child: Text('Continua',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)))),
                  ),
                ],
              ),
              10.heightBox
            ]),
          )
              .animate()
              .fadeIn()
              .scale(
                  begin: const Offset(0.5, 0.5),
                  end: const Offset(1, 1),
                  duration: 850.ms,
                  curve: Curves.easeOutExpo)
              .slideY(
                  begin: 1, end: 0, duration: 850.ms, curve: Curves.easeOutExpo)
        ],
      ),
    );
  }
}
