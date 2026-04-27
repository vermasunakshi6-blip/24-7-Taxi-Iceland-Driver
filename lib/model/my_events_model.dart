class MyEventsModel {
  int? status;
  int? totalEvents;
  List<MyEventsData>? data;
  Errors? errors;
  MyEventsModel({this.status, this.totalEvents, this.data,this.errors});
  MyEventsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalEvents = json['totalEvents'];
    errors =
        json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    if (json['data'] != null) {
      data = <MyEventsData>[];
      json['data'].forEach((v) {
        data!.add(MyEventsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['totalEvents'] = totalEvents;
    if (errors != null) {
      data['errors'] = errors!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MyEventsData {
  String? sId;
  String? userId;
  String? userName;
  String? eventName;
  String? eventDate;
  String? eventTime;
  String? eventEndDate;
  String? eventEndTime;
  String? eventType;
  String? address1;
  MyEventsLocation? location;
  String? state;
  String? city;
  int? status;
  String? eventPic;
  String? description;
  String? sponsorName;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? eventPicPath;
  int? totalLikes;
  int? totalLoves;
  int? totalHappies;
  int? totalShocked;
  int? totalSads;
  int? totalAngries;
  int? totalViews;
  int? totalRides;
  String? email;
  String? countryCode;
  String? phone;

  MyEventsData(
      {this.sId,
      this.userId,
      this.userName,
      this.eventName,
      this.eventDate,
      this.eventTime,
      this.eventType,
      this.eventEndDate,
      this.eventEndTime,
      this.address1,
      this.location,
      this.state,
      this.city,
      this.status,
      this.eventPic,
      this.description,
      this.sponsorName,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.eventPicPath,
      this.totalLikes,
      this.totalLoves,
      this.totalHappies,
      this.totalShocked,
      this.totalSads,
      this.totalAngries,
      this.totalViews,
      this.totalRides,
      this.email,
      this.countryCode,
      this.phone});

  MyEventsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userName = json['userName'];
    eventName = json['eventName'];
    eventDate = json['eventDate'];
    eventTime = json['eventTime'];
    eventEndDate = json['eventEndDate'];
    eventEndTime = json['eventEndTime'];
    eventType = json['eventType'];
    address1 = json['address1'];
    location = json['location'] != null
        ? MyEventsLocation.fromJson(json['location'])
        : null;
    state = json['state'];
    city = json['city'];
    status = json['status'];
    eventPic = json['eventPic'];
    description = json['description'];
    sponsorName = json['sponsorName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    eventPicPath = json['eventPicPath'];
    totalLikes = json['totalLikes'];
    totalLoves = json['totalLoves'];
    totalHappies = json['totalHappies'];
    totalShocked = json['totalShocked'];
    totalSads = json['totalSads'];
    totalAngries = json['totalAngries'];
    totalViews = json['totalViews'];
    totalRides = json['totalRides'];
    email = json['email'];
    countryCode = json['countryCode'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['userName'] = userName;
    data['eventName'] = eventName;
    data['eventDate'] = eventDate;
    data['eventTime'] = eventTime;
    data['eventDate'] = eventDate;
    data['eventTime'] = eventTime;
    data['eventType'] = eventType;
    data['address1'] = address1;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['state'] = state;
    data['city'] = city;
    data['status'] = status;
    data['eventPic'] = eventPic;
    data['description'] = description;
    data['sponsorName'] = sponsorName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['eventPicPath'] = eventPicPath;
    data['totalLikes'] = totalLikes;
    data['totalLoves'] = totalLoves;
    data['totalHappies'] = totalHappies;
    data['totalShocked'] = totalShocked;
    data['totalSads'] = totalSads;
    data['totalAngries'] = totalAngries;
    data['totalViews'] = totalViews;
    data['totalRides'] = totalRides;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    return data;
  }
}

class MyEventsLocation {
  String? type;
  List<double>? coordinates;

  MyEventsLocation({this.type, this.coordinates});

  MyEventsLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
class Errors {
  String? hmac;

  Errors({this.hmac});

  Errors.fromJson(Map<String, dynamic> json) {
    hmac = json['hmac'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hmac'] = hmac;
    return data;
  }
}