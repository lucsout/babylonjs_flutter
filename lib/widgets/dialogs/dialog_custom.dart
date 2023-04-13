import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogCustom extends StatefulWidget {
  String? text;
  Widget? child;
  double? height;

  DialogCustom({this.text, this.height, this.child});

  @override
  _DialogCustomState createState() => _DialogCustomState();
}

class _DialogCustomState extends State<DialogCustom> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        height: widget.height ?? 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                widget.text!,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Expanded(child: widget.child!)
            ],
          ),
        ),
      ),
    );
  }
}
