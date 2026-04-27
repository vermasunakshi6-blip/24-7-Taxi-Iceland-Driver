class LikeEventModel {
  int? status;
  String? message;
  Data? data;

  LikeEventModel({this.status, this.message, this.data});

  LikeEventModel.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? userId;
  String? eventId;
  String? isLike;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.userId,
      this.eventId,
      this.isLike,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    eventId = json['eventId'];
    isLike = json['is_like'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['eventId'] = eventId;
    data['is_like'] = isLike;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}