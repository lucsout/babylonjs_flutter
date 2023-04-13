import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty/customs/custom_applications.dart';

class LoadingWidget extends StatelessWidget {
  Widget? child;
  String? text;
  Color? color;
  double? size;

  LoadingWidget({this.child, this.text, this.size, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
                    child: SpinKitWave(
                        color: color ?? CustomApplication.accentColor,
                        size: size ?? 48))
                .animate()
                .scale(curve: Curves.easeOutExpo)
                .fadeIn(),
          ],
        ),
        if (text != null) 25.0.heightBox,
        if (text != null)
          Text(text ?? '',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300, fontSize: 18))
              .animate()
              .slideY(duration: 1280.ms, curve: Curves.easeOutExpo)
      ],
    );
  }
}
