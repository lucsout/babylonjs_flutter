import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:sporty/customs/custom_applications.dart';

class CustomButtonWidget extends StatefulWidget {
  Color? color;
  Color? forecolor;

  String? text;
  Future Function()? onTap;

  bool? disableAnimation;

  CustomButtonWidget(
      {this.text,
      this.color,
      this.disableAnimation,
      this.forecolor,
      this.onTap,
      super.key});

  @override
  State<CustomButtonWidget> createState() => _CustomButtonWidgetState();
}

class _CustomButtonWidgetState extends State<CustomButtonWidget> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    if (!(widget.disableAnimation ?? false)) {
      return RoundedLoadingButton(
              controller: _btnController,
              elevation: 0,
              width: context.width,
              valueColor: widget.forecolor ?? Colors.white,
              color: widget.color ?? CustomApplication.accentColor,
              onPressed: () async {
                if (widget.onTap != null) {
                  await widget.onTap!();

                  _btnController.reset();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: AutoSizeText(widget.text ?? '',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: widget.forecolor ?? Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              )).animate(delay: 450.ms).fadeIn().slideY(
            begin: -1,
            end: 0,
            duration: 1280.ms,
            curve: Curves.fastLinearToSlowEaseIn,
          );
    } else {
      return RoundedLoadingButton(
          controller: _btnController,
          elevation: 0,
          width: context.width,
          valueColor: widget.forecolor ?? Colors.white,
          color: widget.color ?? CustomApplication.accentColor,
          onPressed: () async {
            if (widget.onTap != null) {
              await widget.onTap!();

              _btnController.reset();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: AutoSizeText(widget.text ?? '',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    color: widget.forecolor ?? Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ));
    }
  }
}
