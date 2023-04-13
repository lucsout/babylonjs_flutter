import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/controllers/login_controller.dart';
import 'package:sporty/models/corso_booking.dart';

import '../models/corso.dart';
import '../models/socio.dart';

class CorsiController extends GetxController {
  Future<List<Corso>> getCorsi() async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://app.edilab.it/WSJSON/wsgsp.svc/getCourseNew/2/appId/${loginController.appID!}/idsede/${loginController.idSede!}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var stringRes = await response.stream.bytesToString();
      var stringJson = jsonDecode(stringRes);

      if (stringJson != null && stringJson is List && stringJson.isNotEmpty) {
        var listDiscipline = stringJson.map((e) => Corso.fromJson(e)).toList();
        return listDiscipline;
      } else {
        return [];
      }
    }

    return [];
  }

  Future<CorsoBooking?> getSingleCorso(int id) async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://app.edilab.it/WSJSON/wsgsp.svc/getSinglePlannerNew/${id.toString()}/appId/${loginController.appID}/tokenId/${loginController.tokenID}/idsede/${loginController.idSede}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var stringRes = await response.stream.bytesToString();
      var stringJson = jsonDecode(stringRes);

      var corsoBook =
          CorsoBooking.fromJson(stringJson["getSinglePlannerNewResult"]);
      return corsoBook;
    }

    return null;
  }
}
