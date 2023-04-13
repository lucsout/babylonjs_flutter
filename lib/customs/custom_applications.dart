import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

enum CustomApplicationName {
  sporty,
  mygsp,
  sprint,
}

class CustomApplication {
  static CustomApplicationName? symbol;
  static String get name => symbol?.name ?? '';

  static String get WS_URL => "https://app.edilab.it/WSJSON/wsgsp.svc/";

  static String get title {
    switch (symbol) {
      case CustomApplicationName.sporty:
        return 'Sporty';
      case CustomApplicationName.mygsp:
        return 'MyGSP';
      default:
        return 'title';
    }
  }

  static Color get accentColor {
    switch (symbol) {
      case CustomApplicationName.sporty:
        return HexColor("#E71F79");
      default:
        return Colors.black;
    }
  }

  static Color get backgroundColor {
    switch (symbol) {
      case CustomApplicationName.sporty:
        return HexColor("#F4F6FA");
      default:
        return Colors.black;
    }
  }

  static Color get menuSelected {
    switch (symbol) {
      case CustomApplicationName.sporty:
        return HexColor("#E71F79");
      default:
        return Colors.black;
    }
  }

  static Color get menuTextSelected {
    switch (symbol) {
      case CustomApplicationName.sporty:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  static Color get textColor {
    switch (symbol) {
      case CustomApplicationName.sporty:
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  static String get assetLogo {
    switch (symbol) {
      case CustomApplicationName.sporty:
        return 'assets/images/logo/Sporty_bianco.png';
      default:
        return 'assets/images/logo/Sporty_bianco.png';
    }
  }
}
