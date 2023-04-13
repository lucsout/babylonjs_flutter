import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/centro_fitness.dart';

class LoginController extends GetxController {
  String? appID;
  String? tokenID;
  String? idSede;

  String? emailSocio;

  Future<bool> saveData(String appId, String sede, String codiceTessera,
      String email, String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('APPID', appId);
    await prefs.setString('TOKENID', token);
    await prefs.setString('IDSEDE', sede);
    await prefs.setString('EMAILSOCIO', email);

    return false;
  }

  Future<bool> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    appID = prefs.getString('APPID');
    tokenID = prefs.getString('TOKENID');
    idSede = prefs.getString('IDSEDE');
    emailSocio = prefs.getString('EMAILSOCIO');

    return true;
  }

  Future<bool> loginSocio(
      String appId, String sede, String codiceTessera, String email) async {
    var headers = {'Content-Type': 'application/json'};

    var request = http.Request('POST',
        Uri.parse('https://app.edilab.it/WSJSON/wsgsp.svc/registersocio'));
    request.headers.addAll(headers);
    request.body = jsonEncode({
      "AppId": appId,
      "sCodTessera": codiceTessera,
      "sEmail": email,
      "dDataNascita": "01/01/1900",
      "id_sede": sede
    });
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = jsonDecode(await response.stream.bytesToString());

      if ((result as Map).containsKey('Token_id')) {
        tokenID = result["Token_id"];
        appID = appId;
        idSede = sede;

        emailSocio = email;

        await saveData(appId, sede, codiceTessera, email, tokenID!);

        return true;
      }
    }

    return false;
  }
}
