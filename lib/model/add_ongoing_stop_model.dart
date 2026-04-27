class AddOngoingStopModel {
  int? status;
  String? message;
  List<Data>? data;

  AddOngoingStopModel({this.status, this.message, this.data});

  AddOngoingStopModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  String? rideId;
  String? stopAddress;
  double? stopLatitude;
  double? stopLongitude;
  int? status;
  String? sId;
  String? createdAt;
  int? iV;

  Data(
      {this.rideId,
      this.stopAddress,
      this.stopLatitude,
      this.stopLongitude,
      this.status,
      this.sId,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    rideId = json['rideId'];
    stopAddress = json['stop_address'];
    stopLatitude = json['stop_latitude'];
    stopLongitude = json['stop_longitude'];
    status = json['status'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rideId'] = rideId;
    data['stop_address'] = stopAddress;
    data['stop_latitude'] = stopLatitude;
    data['stop_longitude'] = stopLongitude;
    data['status'] = status;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}