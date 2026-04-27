class GetStopsModel {
  int? status;
  String? message;
  List<StopsData>? data;

  GetStopsModel({this.status, this.message, this.data});

  GetStopsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StopsData>[];
      json['data'].forEach((v) {
        data!.add(StopsData.fromJson(v));
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

class StopsData {
  String? sId;
  String? rideId;
  String? stopAddress;
  double? stopLatitude;
  double? stopLongitude;
  int? status;
  String? createdAt;
  int? iV;

  StopsData(
      {this.sId,
      this.rideId,
      this.stopAddress,
      this.stopLatitude,
      this.stopLongitude,
      this.status,
      this.createdAt,
      this.iV});

  StopsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    rideId = json['rideId'];
    stopAddress = json['stop_address'];
    stopLatitude = json['stop_latitude'];
    stopLongitude = json['stop_longitude'];
    status = json['status'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['rideId'] = rideId;
    data['stop_address'] = stopAddress;
    data['stop_latitude'] = stopLatitude;
    data['stop_longitude'] = stopLongitude;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['__v'] = iV;
    return data;
  }
}