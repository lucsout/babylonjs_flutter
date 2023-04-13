import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/widgets/base/custom_text_form.dart';

class SearchWidget extends StatefulWidget {
  String? text;
  Function(String)? onSearched;

  SearchWidget({this.onSearched, this.text, super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Positioned.fill(
                child: Container(
              decoration: BoxDecoration(
                  color: CustomApplication.backgroundColor,
                  borderRadius: BorderRadius.circular(20)),
            )),
            CustomTextFormField(
              hintText: widget.text ?? 'Ricerca',
              borderColor: Colors.black12,
              onchanged: (val) {
                search = val;

                if (widget.onSearched != null) {
                  widget.onSearched!(search);
                }
              },
            ),
            Positioned(
              right: 20,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  if (widget.onSearched != null) {
                    widget.onSearched!(search);
                  }
                },
                child: const Icon(
                  EvaIcons.searchOutline,
                  size: 32,
                  color: Colors.black38,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
