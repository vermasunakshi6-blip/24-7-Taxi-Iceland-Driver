class AllEventsModel {
  int? status;
  List<EventData>? data;

  AllEventsModel({this.status, this.data});

  AllEventsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <EventData>[];
      json['data'].forEach((v) {
        data!.add(EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventData {
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
  EventLocation? location;
  String? state;
  String? city;
  int? status;
  String? eventPic;
  String? description;
  String? sponsorName;
  String? createdAt;
  String? updatedAt;
  int? iV;
  dynamic isLike;
  int? totallikeCount;
  int? totalLoveCount;
  int? totalHappyCount;
  int? totalShockedCount;
  int? totalSadCount;
  int? totalAngryCount;
  int? totalReactionCount;
  int? totalviewsCount;
  List<NearDrivers>? nearDrivers;

  EventData(
      {this.sId,
      this.userId,
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
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.isLike,
      this.totallikeCount,
      this.totalLoveCount,
      this.totalHappyCount,
      this.totalShockedCount,
      this.totalSadCount,
      this.totalAngryCount,
      this.totalReactionCount,
      this.totalviewsCount,
      this.nearDrivers});

  EventData.fromJson(Map<String, dynamic> json) {
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
        ? EventLocation.fromJson(json['location'])
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
    isLike = json['is_like'];
    totallikeCount = json['totallikeCount'];
    totalLoveCount = json['totalLoveCount'];
    totalHappyCount = json['totalHappyCount'];
    totalShockedCount = json['totalShockedCount'];
    totalSadCount = json['totalSadCount'];
    totalAngryCount = json['totalAngryCount'];
    totalReactionCount = json['totalReactionCount'];
    totalviewsCount = json['totalviewsCount'];
    if (json['nearDrivers'] != null) {
      nearDrivers = <NearDrivers>[];
      json['nearDrivers'].forEach((v) {
        nearDrivers!.add(NearDrivers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['is_like'] = isLike;
    data['totallikeCount'] = totallikeCount;
    data['totalLoveCount'] = totalLoveCount;
    data['totalHappyCount'] = totalHappyCount;
    data['totalShockedCount'] = totalShockedCount;
    data['totalSadCount'] = totalSadCount;
    data['totalAngryCount'] = totalAngryCount;
    data['totalReactionCount'] = totalReactionCount;
    data['totalviewsCount'] = totalviewsCount;
    if (nearDrivers != null) {
      data['nearDrivers'] = nearDrivers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventLocation {
  String? type;
  List<double>? coordinates;

  EventLocation({this.type, this.coordinates});

  EventLocation.fromJson(Map<String, dynamic> json) {
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

class NearDrivers {
  String? sId;
  String? firstName;
  String? lastName;
  double? latitude;
  double? longitude;

  NearDrivers(
      {this.sId, this.firstName, this.lastName, this.latitude, this.longitude});

  NearDrivers.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}