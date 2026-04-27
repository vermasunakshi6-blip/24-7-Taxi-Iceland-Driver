class AddDraftModel {
  int? status;
  String? message;
  Data? data;

  AddDraftModel({this.status, this.message, this.data});

  AddDraftModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? userName;
  String? eventName;
  String? eventDate;
  String? eventTime;
  String? eventEndDate;
  String? eventEndTime;
  String? eventType;
  String? address1;
  Location? location;
  String? state;
  String? city;
  int? status;
  String? eventPic;
  String? description;
  String? sponsorName;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.userId,
      this.userName,
      this.eventName,
      this.eventDate,
      this.eventTime,
      this.eventEndDate,
      this.eventEndTime,
      this.eventType,
      this.address1,
      this.location,
      this.state,
      this.city,
      this.status,
      this.eventPic,
      this.description,
      this.sponsorName,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
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
        ? Location.fromJson(json['location'])
        : null;
    state = json['state'];
    city = json['city'];
    status = json['status'];
    eventPic = json['eventPic'];
    description = json['description'];
    sponsorName = json['sponsorName'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['userName'] = userName;
    data['eventName'] = eventName;
    data['eventDate'] = eventDate;
    data['eventTime'] = eventTime;
    data['eventEndDate'] = eventEndDate;
    data['eventEndTime'] = eventEndTime;
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
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Location {
  String? type;
  List<int>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}