class CancelEventModel {
  int? status;
  String? message;
  EventData? eventData;

  CancelEventModel({this.status, this.message, this.eventData});

  CancelEventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    eventData = json['eventData'] != null
        ? EventData.fromJson(json['eventData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (eventData != null) {
      data['eventData'] = eventData!.toJson();
    }
    return data;
  }
}

class EventData {
  Location? location;
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
  String? state;
  String? city;
  int? status;
  String? eventPic;
  String? description;
  String? sponsorName;
  String? createdAt;
  String? updatedAt;
  int? iV;

  EventData(
      {this.location,
      this.sId,
      this.userId,
      this.userName,
      this.eventName,
      this.eventDate,
      this.eventTime,
      this.eventEndDate,
      this.eventEndTime,
      this.eventType,
      this.address1,
      this.state,
      this.city,
      this.status,
      this.eventPic,
      this.description,
      this.sponsorName,
      this.createdAt,
      this.updatedAt,
      this.iV});

  EventData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
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
    state = json['state'];
    city = json['city'];
    status = json['status'];
    eventPic = json['eventPic'];
    description = json['description'];
    sponsorName = json['sponsorName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['userId'] = userId;
    data['userName'] = userName;
    data['eventName'] = eventName;
    data['eventDate'] = eventDate;
    data['eventTime'] = eventTime;
    data['eventEndDate'] = eventEndDate;
    data['eventEndTime'] = eventEndTime;
    data['eventType'] = eventType;
    data['address1'] = address1;
    data['state'] = state;
    data['city'] = city;
    data['status'] = status;
    data['eventPic'] = eventPic;
    data['description'] = description;
    data['sponsorName'] = sponsorName;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
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