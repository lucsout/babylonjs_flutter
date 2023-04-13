class Corso {
  String? activityId;
  List<Times>? fridayTimes;
  List<Times>? mondayTimes;
  String? name;
  List<Times>? saturdayTimes;
  List<Times>? sundayTimes;
  List<Times>? thursdayTimes;
  List<Times>? tuesdayTimes;
  List<Times>? wednesdayTimes;

  String? disciplina;
  String? grpDisciplina;
  int? disciplinaID;
  int? grpDisciplinaID;

  Corso(
      {this.activityId,
      this.fridayTimes,
      this.mondayTimes,
      this.name,
      this.saturdayTimes,
      this.sundayTimes,
      this.thursdayTimes,
      this.tuesdayTimes,
      this.wednesdayTimes});

  Corso.fromJson(Map<String, dynamic> json) {
    disciplina = json["Disciplina"];
    grpDisciplina = json["GrpDisciplina"];
    disciplinaID = json["DisciplinaID"];
    grpDisciplinaID = json["GrpDisciplinaID"];

    activityId = json['ActivityId'];
    if (json['FridayTimes'] != null) {
      fridayTimes = <Times>[];
      json['FridayTimes'].forEach((v) {
        fridayTimes!.add(Times.fromJson(v));
      });
    }
    if (json['MondayTimes'] != null) {
      mondayTimes = <Times>[];
      json['MondayTimes'].forEach((v) {
        mondayTimes!.add(Times.fromJson(v));
      });
    }
    name = json['Name'];
    if (json['SaturdayTimes'] != null) {
      saturdayTimes = <Times>[];
      json['SaturdayTimes'].forEach((v) {
        saturdayTimes!.add(Times.fromJson(v));
      });
    }
    if (json['SundayTimes'] != null) {
      sundayTimes = <Times>[];
      json['SundayTimes'].forEach((v) {
        sundayTimes!.add(Times.fromJson(v));
      });
    }
    if (json['ThursdayTimes'] != null) {
      thursdayTimes = <Times>[];
      json['ThursdayTimes'].forEach((v) {
        thursdayTimes!.add(Times.fromJson(v));
      });
    }
    if (json['TuesdayTimes'] != null) {
      tuesdayTimes = <Times>[];
      json['TuesdayTimes'].forEach((v) {
        tuesdayTimes!.add(Times.fromJson(v));
      });
    }
    if (json['WednesdayTimes'] != null) {
      wednesdayTimes = <Times>[];
      json['WednesdayTimes'].forEach((v) {
        wednesdayTimes!.add(Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ActivityId'] = this.activityId;
    if (this.fridayTimes != null) {
      data['FridayTimes'] = this.fridayTimes!.map((v) => v.toJson()).toList();
    }
    if (this.mondayTimes != null) {
      data['MondayTimes'] = this.mondayTimes!.map((v) => v.toJson()).toList();
    }
    data['Name'] = this.name;
    if (this.saturdayTimes != null) {
      data['SaturdayTimes'] =
          this.saturdayTimes!.map((v) => v.toJson()).toList();
    }
    if (this.sundayTimes != null) {
      data['SundayTimes'] = this.sundayTimes!.map((v) => v.toJson()).toList();
    }
    if (this.thursdayTimes != null) {
      data['ThursdayTimes'] =
          this.thursdayTimes!.map((v) => v.toJson()).toList();
    }
    if (this.tuesdayTimes != null) {
      data['TuesdayTimes'] = this.tuesdayTimes!.map((v) => v.toJson()).toList();
    }
    if (this.wednesdayTimes != null) {
      data['WednesdayTimes'] =
          this.wednesdayTimes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  String? hourStart;
  String? hourStop;
  int? idCourse;
  String? structure;

  Times({this.hourStart, this.hourStop, this.idCourse, this.structure});

  Times.fromJson(Map<String, dynamic> json) {
    hourStart = json['Hour_start'];
    hourStop = json['Hour_stop'];
    idCourse = json['IdCourse'];
    structure = json['Structure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Hour_start'] = this.hourStart;
    data['Hour_stop'] = this.hourStop;
    data['IdCourse'] = this.idCourse;
    data['Structure'] = this.structure;
    return data;
  }
}
