import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/centro_fitness.dart';

class CentroController extends GetxController {
  Future<List<CentroFitness>> getMultiazienda() async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://app.edilab.it/WSJSON/wsgsp.svc/getMultiaziendaSporty'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      Map<String, dynamic> maps = jsonDecode(jsonDecode(result));

      List<CentroFitness> centri = [];

      for (MapEntry<String, dynamic> entry in maps.entries) {
        var centro = CentroFitness();
        centro.appid = entry.key;
        centro.nomeCentro = entry.value.toString();

        centri.add(centro);
      }

      return centri;
    } else {}

    return [];
  }
}
