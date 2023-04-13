import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sporty/customs/custom_applications.dart';
import 'package:sporty/widgets/base/loading_widget.dart';

import 'custom_future_builder.dart';
import 'filter_element_widget.dart';

class CustomDropdownWidget extends StatefulWidget {
  final String? hint;
  final String? value;

  final void Function(String?)? onchanged;
  final Future<List<String>> Function()? onClickCallback;
  final void Function(String?)? onCleared;

  const CustomDropdownWidget(
      {Key? key,
      this.onCleared,
      this.onClickCallback,
      this.value,
      this.onchanged,
      this.hint})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdownWidget>
    with TickerProviderStateMixin {
  GlobalKey key = GlobalKey();

  bool expanded = false;
  bool isDropdownSelected = false;

  String? selectedValue = '';

  @override
  void initState() {
    if (widget.value != null && widget.value != '') {
      selectedValue = widget.value;
      isDropdownSelected = true;
    }

    super.initState();
  }

  Widget _buildElement(String element, int index) {
    return GestureDetector(
      onTap: () {
        if (widget.onchanged != null) {
          widget.onchanged!(element);

          setState(() {
            selectedValue = element;
            isDropdownSelected = true;
          });

          Navigator.pop(context);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: CustomApplication.backgroundColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Text(element,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.black)),
            ),
          ],
        ),
      ).animate(delay: (25 * index).ms).fadeIn().slideY(
          begin: 1, end: 0, curve: Curves.easeOutExpo, duration: 850.ms),
    );
  }

  void showPopup() async {
    await showDialog(
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 1,
            backgroundColor: Colors.transparent,
            contentPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Listener(
                      onPointerDown: (down) {
                        Navigator.pop(context);
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.transparent),
                    ),
                  ),
                  Positioned.fill(
                      child: Container(
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(35),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: CustomFutureBuilder<List<String>>(
                              future: widget.onClickCallback!(),
                              child: (snapshot) {
                                return Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      10.0.heightBox,
                                      Text('Seleziona il tuo centro:',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w200,
                                              fontSize: 18,
                                              color: Colors.black)),
                                      10.0.heightBox,
                                      Expanded(
                                        child: FadingEdgeScrollView
                                            .fromSingleChildScrollView(
                                          child: SingleChildScrollView(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            controller: ScrollController(),
                                            child: ListView.separated(
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return _buildElement(
                                                      snapshot[index], index);
                                                },
                                                separatorBuilder: (context,
                                                        index) =>
                                                    const SizedBox(height: 10),
                                                shrinkWrap: true,
                                                itemCount:
                                                    (snapshot as List<String>)
                                                        .length),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })))
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          showPopup();
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            FilterElementWidget(
                selectedValue!.isNotEmpty ? selectedValue : widget.hint,
                isEnabled: isDropdownSelected),
            isDropdownSelected
                ? Positioned(
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        widget.onCleared?.call(selectedValue);

                        setState(() {
                          isDropdownSelected = false;
                          selectedValue = '';
                        });
                      },
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Center(
                          child: Icon(Icons.clear,
                              color: Colors.redAccent.withOpacity(0.95)),
                        ),
                      ),
                    ))
                : Container()
          ],
        ));
  }
}
