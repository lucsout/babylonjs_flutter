import 'package:get/get.dart';
import 'package:sporty/controllers/login_controller.dart';

class Prenotazione {
  String? color;
  String? corso;
  String? data;
  String? dateTimeFinish;
  String? dateTimeStart;
  int? iD;
  String? orario;
  String? stato;

  Prenotazione(
      {this.color,
      this.corso,
      this.data,
      this.dateTimeFinish,
      this.dateTimeStart,
      this.iD,
      this.orario,
      this.stato});

  Prenotazione.fromJson(Map<String, dynamic> json) {
    color = json['Color'];
    corso = json['Corso'];
    data = json['Data'];
    dateTimeFinish = json['DateTimeFinish'];
    dateTimeStart = json['DateTimeStart'];
    iD = json['ID'];
    orario = json['Orario'];
    stato = json['Stato'];
  }
}
