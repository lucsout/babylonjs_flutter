import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class FilterElementWidget extends StatefulWidget {
  String? label;
  bool? isEnabled;

  FilterElementWidget(this.label, {this.isEnabled});

  @override
  _FilterElementWidgetState createState() => _FilterElementWidgetState();
}

class _FilterElementWidgetState extends State<FilterElementWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: (widget.isEnabled ?? false)
              ? Border.all(color: HexColor('#A4A2F5').withOpacity(0.85))
              : Border.all(color: Colors.grey.withOpacity(0.85)),
          color: (widget.isEnabled ?? false)
              ? HexColor('#A4A2F5').withOpacity(0.25)
              : Colors.white,
          borderRadius: BorderRadius.circular(25)),
      child: Transform.translate(
          offset: Offset(widget.isEnabled! ? -10 : 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              !widget.isEnabled! ? const SizedBox(width: 8) : Container(),
              Text(widget.label!,
                  style: GoogleFonts.poppins(
                      color:
                          widget.isEnabled! ? Colors.white70 : Colors.black)),
              !widget.isEnabled! ? const SizedBox(width: 4) : Container(),
              !widget.isEnabled!
                  ? Icon(EvaIcons.arrowIosDownwardOutline,
                      color: Colors.grey.withOpacity(0.85))
                  : Container()
            ],
          )),
    );
  }
}
