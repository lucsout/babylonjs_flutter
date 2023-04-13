import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/widgets/base/loading_widget.dart';

class DialogLoading extends StatefulWidget {
  String? title;

  DialogLoading({super.key, this.title});

  @override
  _DialogLoadingState createState() => _DialogLoadingState();
}

class _DialogLoadingState extends State<DialogLoading> {
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
                      color: CustomApplication.accentColor,
                      height: 80,
                      child: LoadingWidget(color: Colors.white, size: 32))),
              Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  widget.title ?? 'Caricamento..',
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 18),
                ),
              ),
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
