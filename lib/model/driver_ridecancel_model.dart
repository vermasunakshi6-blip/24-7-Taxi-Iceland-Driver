class DriverCancelModel {
  int? status;
  String? message;
  Data? data;

  DriverCancelModel({this.status, this.message, this.data});

  DriverCancelModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? reason;
  int? status;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.rideid,
      this.driverid,
      this.type,
      this.reason,
      this.status,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    rideid = json['rideid'];
    driverid = json['driverid'];
    type = json['type'];
    reason = json['reason'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rideid'] = rideid;
    data['driverid'] = driverid;
    data['type'] = type;
    data['reason'] = reason;
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
