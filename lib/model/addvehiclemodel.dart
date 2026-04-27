class AddVehicleModel {
  int? status;
  String? message;
  Data? data;

  AddVehicleModel({this.status, this.message, this.data});

  AddVehicleModel.fromJson(Map<String, dynamic> json) {
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
  String? vehicleId;
  String? vehicleType;
  String? vehicleMake;
  String? vehicleModel;
  String? vehicleYear;
  String? registrationNumber;
  String? vehicleColor;
  List<String>? vehicleImages;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.driverid,
      this.vehicleId,
      this.vehicleType,
      this.vehicleMake,
      this.vehicleModel,
      this.vehicleYear,
      this.registrationNumber,
      this.vehicleColor,
      this.vehicleImages,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    driverid = json['driverid'];
    vehicleId = json['vehicle_id'];
    vehicleType = json['vehicle_type'];
    vehicleMake = json['vehicle_make'];
    vehicleModel = json['vehicle_model'];
    vehicleYear = json['vehicle_year'];
    registrationNumber = json['registration_number'];
    vehicleColor = json['vehicle_color'];
    vehicleImages = json['vehicle_images'].cast<String>();
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['driverid'] = driverid;
    data['vehicle_id'] = vehicleId;
    data['vehicle_type'] = vehicleType;
    data['vehicle_make'] = vehicleMake;
    data['vehicle_model'] = vehicleModel;
    data['vehicle_year'] = vehicleYear;
    data['registration_number'] = registrationNumber;
    data['vehicle_color'] = vehicleColor;
    data['vehicle_images'] = vehicleImages;
    data['_id'] =sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}