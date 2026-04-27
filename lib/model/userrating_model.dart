class UserRatingsModel {
  int? status;
  String? message;
  Data? data;

  UserRatingsModel({this.status, this.message, this.data});

  UserRatingsModel.fromJson(Map<String, dynamic> json) {
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
  String? driverid;
  String? userId;
  dynamic tripRating;
  String? comment;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.rideid,
      this.driverid,
      this.userId,
      this.tripRating,
      this.comment,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    rideid = json['rideid'];
    driverid = json['driverid'];
    userId = json['userId'];
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
    data['driverid'] = driverid;
    data['userId'] = userId;
    data['tripRating'] = tripRating;
    data['comment'] = comment;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
