import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:sporty/customs/custom_applications.dart';

class CustomCalendarWidget extends StatefulWidget {
  DateTime? rangeFrom;
  DateTime? rangeTo;

  CustomCalendarWidget({this.rangeFrom, this.rangeTo, super.key});

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget>
    with TickerProviderStateMixin {
  int? meseCorrente;
  DateTime? inizioMese;
  DateTime? fineMese;
  DateTime? inizioCalendar;

  var showCalendar = true.obs;

  final PageController _pageController = PageController();
  late AnimationController _animcontroller;

  var nomeMese = ''.obs;
  var nomeMeseToChange = ''.obs;

  @override
  void initState() {
    super.initState();

    _animcontroller = AnimationController(vsync: this);

    meseCorrente = DateTime.now().month;
    inizioMese = DateTime.utc(DateTime.now().year, meseCorrente!, 1);

    fineMese = DateTime.utc(DateTime.now().year, meseCorrente! + 1, 0);

    inizioCalendar =
        inizioMese!.subtract(Duration(days: inizioMese!.weekday - 1)).toUtc();

    nomeMese.value = DateFormat("MMMM", 'it-IT').format(DateTime.now());
    nomeMeseToChange.value = nomeMese.value;
  }

  @override
  void dispose() {
    super.dispose();

    _animcontroller.dispose();
  }

  DateTime getInizioCalendar(int month) {
    var iniz = DateTime.utc(DateTime.now().year, month, 1);

    return iniz.subtract(Duration(days: iniz.weekday - 1)).toUtc();
  }

  String capitalize(String text) {
    return "${text[0].toUpperCase()}${text.substring(1).toLowerCase()}";
  }

  Widget _buildAnimatedMonthName() {
    return ClipRRect(
      child: Stack(
        children: [
          AutoSizeText(
                  "${nomeMeseToChange.value[0].toUpperCase()}${nomeMeseToChange.value.substring(1).toLowerCase()}",
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      height: 1.2,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: Colors.white))
              .animate(controller: _animcontroller)
              .custom(
                duration: 650.ms,
                begin: 1,
                end: 0,
                curve: Curves.easeOutExpo,
                builder: (_, value, child) {
                  return Transform.translate(
                      offset: Offset(0, -(value * 30)),
                      child: Opacity(opacity: 1, child: child));
                },
              ),
          AutoSizeText(
                  "${nomeMese.value[0].toUpperCase()}${nomeMese.value.substring(1).toLowerCase()}",
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                      height: 1.2,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: Colors.white))
              .animate(controller: _animcontroller)
              .custom(
                duration: 650.ms,
                begin: 0,
                end: 1,
                curve: Curves.easeOutExpo,
                builder: (_, value, child) {
                  return Transform.translate(
                      offset: Offset(0, value * 30),
                      child: Opacity(opacity: 1, child: child));
                },
              ),
        ],
      ),
    );
  }

  Widget _buildMonthName() {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => _buildAnimatedMonthName()),
          ],
        ),
        Positioned(
            left: 5,
            top: 0,
            bottom: 0,
            child: GestureDetector(
                onTap: () {
                  _pageController.previousPage(
                      duration: 450.ms, curve: Curves.easeOutExpo);
                },
                child: const Icon(EvaIcons.arrowIosBackOutline,
                    color: Colors.white, size: 22))),
        Positioned(
            right: 5,
            top: 0,
            bottom: 0,
            child: Row(
              children: [
                GestureDetector(
                    onTap: () {
                      showCalendar.value = false;
                    },
                    child: Icon(FontAwesomeIcons.list,
                        color: Colors.white.withOpacity(0.65), size: 16)),
                15.widthBox,
                GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                          duration: 450.ms, curve: Curves.easeOutExpo);
                    },
                    child: const Icon(EvaIcons.arrowIosForward,
                        color: Colors.white, size: 22)),
              ],
            ))
      ],
    );
  }

  Widget _buildDayText(String text) {
    return Center(
      child: AutoSizeText(text,
          maxLines: 1,
          minFontSize: 2,
          style: GoogleFonts.poppins(
              height: 1.2,
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: Colors.white)),
    );
  }

  Widget _buildDayName() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _buildDayText('Lun'),
      _buildDayText('Mar'),
      _buildDayText('Mer'),
      _buildDayText('Gio'),
      _buildDayText('Ven'),
      _buildDayText('Sab'),
      _buildDayText('Dom'),
    ]);
  }

  Color getColorDay(DateTime data) {
    Color toReturn = Colors.white;

    if (data.isBefore(inizioMese!) || data.isAfter(fineMese!)) {
      toReturn = Colors.white.withOpacity(0.15);
    } else {
      toReturn = Colors.white.withOpacity(0.15);
    }

    if (data.isSameDate(fineMese!)) {
      toReturn = Colors.white.withOpacity(0.15);
    }

    if (data.isSameDate(DateTime.now().toUtc())) toReturn = Colors.white;

    //Vedo se le date sono in range
    if (data.isBefore(widget.rangeTo!) && data.isAfter(widget.rangeFrom!)) {
      toReturn = Colors.white;
    }

    if (data.isSameDate(widget.rangeTo!)) toReturn = Colors.white;

    if (data.isSameDate(widget.rangeFrom!)) toReturn = Colors.white;

    return toReturn;
  }

  FontWeight getFontWeight(DateTime data) {
    if (data.isSameDate(DateTime.now().toUtc())) return FontWeight.bold;

    return FontWeight.w300;
  }

  BoxDecoration getBoxDecoration(DateTime data) {
    if (data.isSameDate(DateTime.now().toUtc())) {
      return BoxDecoration(
          color: CustomApplication.accentColor, shape: BoxShape.circle);
    } else {
      return const BoxDecoration();
    }
  }

  Widget _buildGiorniList() {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) {
          var data = widget.rangeFrom!.add(Duration(days: index));

          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: HexColor('#34363A'),
                borderRadius: BorderRadius.circular(15)),
            child: AutoSizeText(
                capitalize(
                    DateFormat('EEEE dd MMMM yyyy', 'it-IT').format(data)),
                maxLines: 1,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    height: 1.2,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Colors.white)),
          );
        },
        separatorBuilder: (_, index) => const SizedBox(height: 10),
        itemCount: widget.rangeTo!.difference(widget.rangeFrom!).inDays);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          color: HexColor('#191B1F'), borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.all(15),
      child: AnimatedSize(
        duration: 650.ms,
        curve: Curves.fastOutSlowIn,
        child: Obx(
          () => AnimatedSwitcher(
              duration: 150.ms,
              child: showCalendar.value
                  ? Column(
                      key: const ValueKey<int>(0),
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildMonthName(),
                        20.heightBox,
                        _buildDayName(),
                        10.heightBox,
                        ExpandablePageView.builder(
                            itemCount: 12,
                            controller: _pageController,
                            physics: const BouncingScrollPhysics(),
                            onPageChanged: (index) {
                              var dataMonth = DateTime(DateTime.now().year,
                                  DateTime.now().month + index, 1);

                              //Aggiungo l'aggiornamento al frame successivo perchè altrimenti da errore in quanto sono già nel metodo build.
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) async {
                                nomeMese.value = nomeMeseToChange.value;
                                nomeMeseToChange.value =
                                    DateFormat("MMMM", 'it-IT')
                                        .format(dataMonth);

                                await _animcontroller.forward(from: 0);
                              });
                            },
                            itemBuilder: (context, index) {
                              var inizioPageCalendar = getInizioCalendar(
                                  DateTime.now().month + index);

                              return GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 7),
                                itemCount: 42,
                                itemBuilder: (_, index) {
                                  var data = inizioPageCalendar
                                      .add(Duration(days: index));

                                  return Container(
                                      margin: const EdgeInsets.all(4),
                                      decoration: getBoxDecoration(data),
                                      child: Center(
                                        child: AutoSizeText(data.day.toString(),
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                                height: 1.2,
                                                fontWeight: getFontWeight(data),
                                                fontSize: 14,
                                                color: getColorDay(data))),
                                      ));
                                },
                              );
                            })
                      ],
                    )
                  : Column(
                      key: const ValueKey<int>(1),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                              child: GestureDetector(
                                  onTap: () {
                                    showCalendar.value = true;
                                  },
                                  child: const Icon(FontAwesomeIcons.calendar,
                                      color: Colors.white, size: 16)),
                            ),
                          ],
                        ),
                        20.heightBox,
                        _buildGiorniList(),
                      ],
                    )),
        ),
      ),
    );
  }
}
