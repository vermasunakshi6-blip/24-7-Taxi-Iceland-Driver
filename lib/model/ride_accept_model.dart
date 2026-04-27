class RideAccept {
  int? status;
  String? message;
  Data? data;

  RideAccept({this.status, this.message, this.data});

  RideAccept.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? driverid;
  String? rideid;
  int? status;
  String? type;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.driverid,
      this.rideid,
      this.status,
      this.type,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    driverid = json['driverid'];
    rideid = json['rideid'];
    status = json['status'];
    type = json['type'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['driverid'] = driverid;
    data['rideid'] = rideid;
    data['status'] = status;
    data['type'] = type;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}