import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTitleWidget extends StatelessWidget {
  String? text;
  int? delay;
  bool? padding;

  CustomTitleWidget({this.text, this.padding, this.delay, super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Padding(
        padding: (padding ?? false)
            ? const EdgeInsets.fromLTRB(25, 0, 25, 0)
            : EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
              child: AutoSizeText(text ?? '',
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black))
                  .animate(delay: (delay ?? 100).ms)
                  .fadeIn()
                  .slideY(
                      begin: 1,
                      end: 0,
                      duration: 850.ms,
                      curve: Curves.easeOutExpo),
            ),
          ],
        ),
      ),
    );
  }
}
