class GetDraftsModel {
  int? status;
  String? message;
  List<DraftData>? data;

  GetDraftsModel({this.status, this.message, this.data});

  GetDraftsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DraftData>[];
      json['data'].forEach((v) {
        data!.add(DraftData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DraftData {
  DraftLocation? location;
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

  DraftData(
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

  DraftData.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? DraftLocation.fromJson(json['location'])
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

class DraftLocation {
  String? type;
  List<dynamic>? coordinates;

  DraftLocation({this.type, this.coordinates});

  DraftLocation.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<dynamic>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}