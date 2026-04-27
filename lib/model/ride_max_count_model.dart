class RideMaxCountModel {
  int? status;
  String? message;
  List<Data>? data;

  RideMaxCountModel({this.status, this.message, this.data});

  RideMaxCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  int? maxCapacity;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data({this.sId, this.maxCapacity, this.createdAt, this.updatedAt, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    maxCapacity = json['max_capacity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['_id'] = sId;
    data['max_capacity'] = maxCapacity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}