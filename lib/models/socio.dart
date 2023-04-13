import 'package:intl/intl.dart';

class Socio {
  String? nominativo;
  String? certificato;
  String? punti;
  String? badge;
  String? codTessera;
  String? foto;
  String? scadenzaAff;
  String? email;
  List<Contratto>? contratto;

  bool affScaduta = false;
  bool hideAff = false;

  Socio(
      {this.nominativo,
      this.certificato,
      this.punti,
      this.badge,
      this.codTessera,
      this.foto,
      this.scadenzaAff,
      this.contratto});

  Socio.fromJson(Map<String, dynamic> json) {
    nominativo = json['nominativo'];
    certificato = json['certificato'];
    punti = json['punti'];
    badge = json['badge'];
    codTessera = json['codTessera'];
    foto = json['foto'];
    scadenzaAff = json['scadenza_aff'];
    if (json['contratto'] != null) {
      contratto = <Contratto>[];
      json['contratto'].forEach((v) {
        contratto!.add(Contratto.fromJson(v));
      });
    }

    try {
      var dataScadAff = DateFormat('dd/MM/yyyy').parse(scadenzaAff ?? '');

      if (dataScadAff.isBefore(DateTime.now())) affScaduta = true;
      if (dataScadAff.isAtSameMomentAs(DateTime.now())) affScaduta = false;
    } on Exception catch (_) {
      affScaduta = true;
      hideAff = true;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['nominativo'] = nominativo;
    data['certificato'] = certificato;
    data['punti'] = punti;
    data['badge'] = badge;
    data['codTessera'] = codTessera;
    data['foto'] = foto;
    data['scadenza_aff'] = scadenzaAff;
    if (contratto != null) {
      data['contratto'] = contratto!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contratto {
  String? descContratto;
  String? dataInizio;
  String? dataTermine;
  String? tipoContratto;
  String? numSeduteContratto;
  String? attivo;
  String? ingressiSettimana;

  Contratto(
      {this.descContratto,
      this.dataInizio,
      this.dataTermine,
      this.tipoContratto,
      this.numSeduteContratto,
      this.attivo,
      this.ingressiSettimana});

  Contratto.fromJson(Map<String, dynamic> json) {
    descContratto = json['descContratto'];
    dataInizio = json['dataInizio'];
    dataTermine = json['dataTermine'];
    tipoContratto = json['tipoContratto'];
    numSeduteContratto = json['numSeduteContratto'];
    attivo = json['attivo'];
    ingressiSettimana = json['ingressi_settimana'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['descContratto'] = descContratto;
    data['dataInizio'] = dataInizio;
    data['dataTermine'] = dataTermine;
    data['tipoContratto'] = tipoContratto;
    data['numSeduteContratto'] = numSeduteContratto;
    data['attivo'] = attivo;
    data['ingressi_settimana'] = ingressiSettimana;
    return data;
  }
}
