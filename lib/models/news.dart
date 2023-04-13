import 'package:intl/intl.dart';

class News {
  DateTime? data;
  int? id;
  String? titolo;
  String? testo;
  String? image;

  News({this.data, this.id, this.titolo, this.testo, this.image});

  News.fromJson(Map<String, dynamic> json) {
    id = json["Id"];
    data = DateFormat('dd/MM/yyyy').parse(json["Data"]);
    titolo = json["Titolo"];
    testo = json["Testo"];
    image = json["Immagine"];
  }
}
