class CorsoBooking {
  String? area;
  BookingOption? bookingOption;
  String? color;
  String? courseName;
  String? date;
  String? hour;
  String? hourStop;
  String? idDisciplina;
  String? image;
  String? isBookable;
  String? itemid;
  String? locationId;
  String? name;
  String? uniqueid;
  String? weekday;

  CorsoBooking(
      {this.area,
      this.bookingOption,
      this.color,
      this.courseName,
      this.date,
      this.hour,
      this.hourStop,
      this.idDisciplina,
      this.image,
      this.isBookable,
      this.itemid,
      this.locationId,
      this.name,
      this.uniqueid,
      this.weekday});

  CorsoBooking.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    bookingOption = json['booking_option'] != null
        ? BookingOption.fromJson(json['booking_option'])
        : null;
    color = json['color'];
    courseName = json['courseName'];
    date = json['date'];
    hour = json['hour'];
    hourStop = json['hour_stop'];
    idDisciplina = json['idDisciplina'];
    image = json['image'];
    isBookable = json['is_bookable'];
    itemid = json['itemid'];
    locationId = json['location_id'];
    name = json['name'];
    uniqueid = json['uniqueid'];
    weekday = json['weekday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    if (bookingOption != null) {
      data['booking_option'] = bookingOption!.toJson();
    }
    data['color'] = color;
    data['courseName'] = courseName;
    data['date'] = date;
    data['hour'] = hour;
    data['hour_stop'] = hourStop;
    data['idDisciplina'] = idDisciplina;
    data['image'] = image;
    data['is_bookable'] = isBookable;
    data['itemid'] = itemid;
    data['location_id'] = locationId;
    data['name'] = name;
    data['uniqueid'] = uniqueid;
    data['weekday'] = weekday;
    return data;
  }
}

class BookingOption {
  int? available;
  int? booked;
  int? closed;
  int? maxQueue;
  int? queue;
  String? userStatus;

  BookingOption(
      {this.available,
      this.booked,
      this.closed,
      this.maxQueue,
      this.queue,
      this.userStatus});

  BookingOption.fromJson(Map<String, dynamic> json) {
    available = json['available'];
    booked = json['booked'];
    closed = json['closed'];
    maxQueue = json['max_queue'];
    queue = json['queue'];
    userStatus = json['user_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['available'] = this.available;
    data['booked'] = this.booked;
    data['closed'] = this.closed;
    data['max_queue'] = this.maxQueue;
    data['queue'] = this.queue;
    data['user_status'] = this.userStatus;
    return data;
  }
}
