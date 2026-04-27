class RatingsModel {
  int? status;
  String? message;
  Data? data;

  RatingsModel({this.status, this.message, this.data});

  RatingsModel.fromJson(Map<String, dynamic> json) {
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
  String? rideid;
  String? userId;
  String? driverid;
  String? tripRating;
  String? comment;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.rideid,
      this.userId,
      this.driverid,
      this.tripRating,
      this.comment,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    rideid = json['rideid'];
    userId = json['userId'];
    driverid = json['driverId'];
    tripRating = json['tripRating'];
    comment = json['comment'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rideid'] = rideid;
    data['userId'] = userId;
    data['driverId'] = driverid;
    data['tripRating'] = tripRating;
    data['comment'] = comment;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
