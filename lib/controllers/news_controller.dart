import 'dart:convert';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sporty/controllers/login_controller.dart';

import '../models/news.dart';
import '../models/socio.dart';

class NewsController extends GetxController {
  Future<List<News>> getNews() async {
    LoginController loginController = Get.find();

    var headers = {'Content-Type': 'application/json'};

    var request = http.Request(
        'GET',
        Uri.parse(
            'https://app.edilab.it/WSJSON/wsgsp.svc/showNews/appId/${loginController.appID!}/idsede/${loginController.idSede!}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var stringRes = await response.stream.bytesToString();
      var stringJson = jsonDecode(stringRes);

      var news = stringJson["showNewsResult"];

      if (news != null && news is List && news.isNotEmpty) {
        return news.map((e) => News.fromJson(e)).toList();
      } else {
        return [];
      }
    }

    return [];
  }
}
