class EventDetailModel {
  int? status;
  String? message;
  List<DetailData>? data;

  EventDetailModel({this.status, this.message, this.data});

  EventDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DetailData>[];
      json['data'].forEach((v) {
        data!.add(DetailData.fromJson(v));
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

class DetailData {
  String? sId;
  String? userId;
  String? userName;
  String? eventName;
  String? eventDate;
  String? eventTime;
  String? eventType;
  String? address1;
  DetailLocation? location;
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
  int? totalviewsCount;
  int? totallikeCount;
  int? totalLoveCount;
  int? totalHappyCount;
  int? totalShockedCount;
  int? totalSadCount;
  int? totalAngryCount;
  int? totalReactionCount;

  DetailData(
      {this.sId,
      this.userId,
      this.userName,
      this.eventName,
      this.eventDate,
      this.eventTime,
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
      this.totalviewsCount,
      this.totallikeCount,
      this.totalLoveCount,
      this.totalHappyCount,
      this.totalShockedCount,
      this.totalSadCount,
      this.totalAngryCount,
      this.totalReactionCount});

  DetailData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    userName = json['userName'];
    eventName = json['eventName'];
    eventDate = json['eventDate'];
    eventTime = json['eventTime'];
    eventType = json['eventType'];
    address1 = json['address1'];
    location = json['location'] != null
        ? DetailLocation.fromJson(json['location'])
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
    totalviewsCount = json['totalviewsCount'];
    totallikeCount = json['totallikeCount'];
    totalLoveCount = json['totalLoveCount'];
    totalHappyCount = json['totalHappyCount'];
    totalShockedCount = json['totalShockedCount'];
    totalSadCount = json['totalSadCount'];
    totalAngryCount = json['totalAngryCount'];
    totalReactionCount = json['totalReactionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['userName'] = userName;
    data['eventName'] = eventName;
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
    data['is_like'] = isLike;
    data['totalviewsCount'] = totalviewsCount;
    data['totallikeCount'] = totallikeCount;
    data['totalLoveCount'] = totalLoveCount;
    data['totalHappyCount'] = totalHappyCount;
    data['totalShockedCount'] = totalShockedCount;
    data['totalSadCount'] = totalSadCount;
    data['totalAngryCount'] = totalAngryCount;
    data['totalReactionCount'] = totalReactionCount;
    return data;
  }
}

class DetailLocation {
  String? type;
  List<double>? coordinates;

  DetailLocation({this.type, this.coordinates});

  DetailLocation.fromJson(Map<String, dynamic> json) {
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
