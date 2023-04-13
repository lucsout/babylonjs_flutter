import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/controllers/login_controller.dart';
import 'package:sporty/models/gallery.dart';

import '../models/socio.dart';

class GalleryController extends GetxController {
  Future<Gallery?> getGalleryInfo() async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://app.edilab.it/WSJSON/wsgsp.svc/getAppSettings/appid/${loginController.appID}/idsede/${loginController.idSede}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonString = await response.stream.bytesToString();
      var result = jsonDecode(jsonString);

      return Gallery.fromJson(result);
    }

    return null;
  }
}
