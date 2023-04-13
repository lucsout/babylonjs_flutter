import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rive/rive.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'dart:math' as math;

class DialogSuccess extends StatefulWidget {
  String? title;
  String? error;

  Widget? body;

  DialogSuccess(this.error, {this.title, this.body}) {}

  @override
  _DialogSuccessState createState() => _DialogSuccessState();
}

class _DialogSuccessState extends State<DialogSuccess> {
  late ConfettiController _controllerBottomLeft;
  late ConfettiController _controllerBottomRight;

  @override
  void initState() {
    super.initState();

    _controllerBottomLeft =
        ConfettiController(duration: const Duration(seconds: 4));

    _controllerBottomRight =
        ConfettiController(duration: const Duration(seconds: 4));

    _controllerBottomLeft.play();
    _controllerBottomRight.play();
  }

  @override
  void dispose() {
    _controllerBottomLeft.dispose();
    _controllerBottomRight.dispose();

    super.dispose();
  }

  Widget _buildConfetti(
      Alignment align, double direction, ConfettiController controller) {
    return Align(
      alignment: align,
      child: ConfettiWidget(
        confettiController: controller,
        minimumSize: const Size(3, 2.5),
        maximumSize: const Size(5, 3.5),
        blastDirection: direction,
        blastDirectionality: BlastDirectionality.directional,
        shouldLoop: false,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ],
      ),
    );
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
                    color: HexColor('#5AB55E'),
                    child: Stack(
                      children: [
                        Transform.scale(
                          scale: 0.75,
                          child: const RiveAnimation.asset(
                            'assets/animations/success.riv',
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        _buildConfetti(Alignment.centerLeft, -(math.pi / 3),
                            _controllerBottomLeft),
                        _buildConfetti(Alignment.centerRight, (math.pi),
                            _controllerBottomRight),
                      ],
                    )),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.error!,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
              widget.body ?? Container(),
              Row(
                children: [
                  Expanded(
                    child: RoundedLoadingButton(
                        controller: RoundedLoadingButtonController(),
                        onPressed: () => Navigator.pop(context),
                        color: CustomApplication.accentColor,
                        borderRadius: 25,
                        animateOnTap: false,
                        child: const Center(
                            child: Text('Ok',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)))),
                  ),
                ],
              )
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
