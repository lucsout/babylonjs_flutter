import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sporty/customs/custom_applications.dart';

class DialogError extends StatefulWidget {
  String? title;
  String? error;

  Widget? body;

  DialogError(this.error, {this.title, this.body}) {}

  @override
  _DialogErrorState createState() => _DialogErrorState();
}

class _DialogErrorState extends State<DialogError> {
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
                child: SizedBox(
                    height: 80,
                    child: Transform.scale(
                      scale: 2,
                      child: const RiveAnimation.asset(
                        'assets/animations/error.riv',
                        fit: BoxFit.fitWidth,
                      ),
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
