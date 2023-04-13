import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/controllers/login_controller.dart';

import '../models/prenotazione.dart';
import '../models/socio.dart';

class SocioController extends GetxController {
  Socio? socio;

  Future<bool> getInfoSocio() async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://app.edilab.it/WSJSON/wsgsp.svc/getInfoSocioNew/${loginController.tokenID!}/${loginController.appID!}/${loginController.idSede!}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var stringJson = jsonDecode(await response.stream.bytesToString());
      var sc = Socio.fromJson(jsonDecode(stringJson));

      if (sc.nominativo != null && sc.nominativo != "") {
        socio = sc;
        socio!.email = loginController.emailSocio;

        return true;
      } else {
        return false;
      }
    }

    return false;
  }

  Future<String> getFotoSocio() async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://app.edilab.it/WSJSON/wsgsp.svc/getFotoSocio/${loginController.tokenID!}/${loginController.appID!}/${loginController.idSede!}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var stringJson = jsonDecode(await response.stream.bytesToString());

      if (stringJson.toString().contains('No data found')) return '';

      var sc = Socio.fromJson(jsonDecode(stringJson));

      if (sc.nominativo != null && sc.nominativo != "") {
        return sc.foto ?? '';
      } else {
        return sc.foto ?? '';
      }
    }

    return '';
  }

  Future<String> prenotaLezione(String uniqueId, String itemId) async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST',
        Uri.parse('https://app.edilab.it/WSJSON/wsgsp.svc/bookingevent'));
    request.headers.addAll(headers);
    request.body = jsonEncode({
      "AppId": loginController.appID,
      "tokenId": loginController.tokenID,
      "UniqueId": uniqueId,
      "ItemId": itemId,
      "id_sede": loginController.idSede
    });

    http.StreamedResponse response = await request.send();

    try {
      if (response.statusCode == 200 || response.statusCode == 403) {
        var stringJson = jsonDecode(await response.stream.bytesToString());
        return "OK-${stringJson['Token_id']}";
      } else {
        return "KO-Si è verificato un errore durante la prenotazione";
      }
    } on Exception catch (_) {
      return "KO-Si è verificato un errore durante l'prenotazione";
    }
  }

  Future<String> annullaLezione(String uniqueId, String itemId) async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST',
        Uri.parse('https://app.edilab.it/WSJSON/wsgsp.svc/deletebookingevent'));
    request.headers.addAll(headers);
    request.body = jsonEncode({
      "AppId": loginController.appID,
      "TokenId": loginController.tokenID,
      "UniqueId": uniqueId,
      "ItemId": itemId,
      "id_sede": loginController.idSede
    });

    http.StreamedResponse response = await request.send();

    try {
      if (response.statusCode == 200 || response.statusCode == 403) {
        var stringJson = jsonDecode(await response.stream.bytesToString());
        return "OK-${stringJson['Token_id']}";
      } else {
        return "KO-Si è verificato un errore durante l'annullamento";
      }
    } on Exception catch (_) {
      return "KO-Si è verificato un errore durante l'annullamento";
    }
  }

  Future<List<Prenotazione>> getPrenotazioniSocio() async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://app.edilab.it/WSJSON/wsgsp.svc/getPrenotazioni/appid/${loginController.appID!}/idsede/${loginController.idSede!}/tokenId/${loginController.tokenID!}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var sss = await response.stream.bytesToString();
      var stringJson = jsonDecode(sss);

      if (stringJson.toString().contains('No data found')) return [];

      try {
        var listPreno = (stringJson["getPrenotazioniResult"] as List);

        return listPreno.map((e) => Prenotazione.fromJson(e)).toList();
      } on Exception catch (_) {
        print(_);
      }
    }

    return [];
  }
}
